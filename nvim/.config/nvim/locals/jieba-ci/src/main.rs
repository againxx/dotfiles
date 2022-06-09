use jieba_rs::Jieba;
use neovim_lib::{Neovim, NeovimApi, Session};
use regex::Regex;

enum Messages {
    Forward,
    Backward,
    Unknonw(String),
}

struct EventHandler {
    nvim: Neovim,
    jieba: Jieba,
}

impl EventHandler {
    fn new() -> EventHandler {
        let session = Session::new_parent().unwrap();
        let nvim = Neovim::new(session);
        let jieba = Jieba::new();
        EventHandler { nvim, jieba }
    }

    fn fallback_move(&mut self, w: bool, count: u64) {
        if w {
            self.nvim.feedkeys(&format!("{}w", count), "n", false).unwrap();
        } else {
            self.nvim.feedkeys(&format!("{}b", count), "n", false).unwrap();
        }
    }

    // Handle events
    fn recv(&mut self) {
        let spaces_re = Regex::new(r"\s+").unwrap();
        let receiver = self.nvim.session.start_event_loop_channel();

        for (event, count) in receiver {
            let count = count[0].as_u64().unwrap_or(1);
            let cursor = self.nvim.get_current_win().unwrap().get_cursor(&mut self.nvim).unwrap();
            let col = cursor.1;
            let line = self.nvim.get_current_line();
            match Messages::from(event) {
                Messages::Forward => {
                    if let Ok(line) = line {
                        let line_after = &line[col as usize..];
                        let parts = self.jieba.cut(line_after, true);
                        if parts.is_empty() {
                            self.fallback_move(true, count);
                        } else {
                            let mut skip_count = 0;
                            let mut skip_len = 0;
                            for part in parts {
                                if !spaces_re.is_match(part) || skip_count == 0 {
                                    // Only count non-empty parts or leading white spaces
                                    skip_count += 1;
                                }
                                if skip_count > count {
                                    break;
                                }
                                skip_len += part.len();
                            }
                            self.nvim.get_current_win().unwrap().set_cursor(&mut self.nvim, (cursor.0, col + skip_len as i64)).unwrap();
                        }
                    } else {
                        self.fallback_move(true, count);
                    }
                }
                Messages::Backward => {
                    if let Ok(line) = line {
                        let line_before = &line[..col as usize];
                        let parts = self.jieba.cut(line_before, true);
                        if parts.is_empty() {
                            self.fallback_move(false, count);
                        } else {
                            let mut skip_count = 0;
                            let mut skip_len = 0;
                            for part in parts.into_iter().rev() {
                                if !spaces_re.is_match(part) {
                                    // Only count non-empty parts or leading white spaces
                                    skip_count += 1;
                                }
                                skip_len += part.len();
                                if skip_count >= count {
                                    break;
                                }
                            }
                            self.nvim.get_current_win().unwrap().set_cursor(&mut self.nvim, (cursor.0, col - skip_len as i64)).unwrap();
                        }
                    } else {
                        self.fallback_move(false, count);
                    }
                }
                Messages::Unknonw(uevent) => {
                    self.nvim.command(&format!("echoerr \"Unsupported movements: {}!\"", uevent)).unwrap();
                }
            }
        }
    }
}

impl From<String> for Messages {
    fn from(event: String) -> Self {
        match &event[..] {
            "forward" => Messages::Forward,
            "backward" => Messages::Backward,
            _ => Messages::Unknonw(event),
        }
    }
}

fn main() {
    let mut event_handler = EventHandler::new();
    event_handler.recv();
}
