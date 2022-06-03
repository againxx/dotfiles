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

    fn fallback_move(&mut self, w: bool) {
        if w {
            self.nvim.feedkeys("w", "n", false).unwrap();
        } else {
            self.nvim.feedkeys("b", "n", false).unwrap();
        }
    }

    // Handle events
    fn recv(&mut self) {
        let receiver = self.nvim.session.start_event_loop_channel();
        let chinese_re = Regex::new(r"^[\u4E00-\u9FFF]+$").unwrap();

        for (event, _) in receiver {
            match Messages::from(event) {
                Messages::Forward => {
                    let line = self.nvim.get_current_line();
                    if let Ok(line) = line {
                        let cursor = self.nvim.get_current_win().unwrap().get_cursor(&mut self.nvim).unwrap();
                        let col = cursor.1;
                        let line_end = &line[col as usize..];
                        let parts = self.jieba.cut(line_end, true);
                        if parts.is_empty() || !chinese_re.is_match(parts[0]) {
                            self.fallback_move(true);
                        } else {
                            self.nvim.get_current_win().unwrap().set_cursor(&mut self.nvim, (cursor.0, col + parts[0].len() as i64)).unwrap();
                        }
                    } else {
                        self.fallback_move(true);
                    }
                }
                Messages::Backward => {
                    let line = self.nvim.get_current_line();
                    if let Ok(line) = line {
                        let cursor = self.nvim.get_current_win().unwrap().get_cursor(&mut self.nvim).unwrap();
                        let col = cursor.1;
                        let line_begin = &line[..col as usize];
                        let parts = self.jieba.cut(line_begin, true);
                        if parts.is_empty() || !chinese_re.is_match(parts.last().unwrap()) {
                            self.fallback_move(false);
                        } else {
                            self.nvim.get_current_win().unwrap().set_cursor(&mut self.nvim, (cursor.0, col - parts.last().unwrap().len() as i64)).unwrap();
                        }
                    } else {
                        self.fallback_move(false);
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
