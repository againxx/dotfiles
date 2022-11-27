-- Set the path to awesome config file
local rc_path = string.format(" %s/.config/awesome/rc.lua", os.getenv("HOME"))

local M = {
  -- Default modkeys
  mod_key = "Mod4", -- It's the Windows logo key on the keyboard.
  alt_key = "Mod1", -- Additional modkey.
  ctrl_key = "Contrl", -- Control button just in case.
  browser = "google-chrome-stable",
  terminal = "wezterm",
  editor = os.getenv("EDITOR") or "vim",
  gui_editor = "xed",
  file_manager = "thunar",
  screen_locker = "light-locker-command -l",
  app_searcher = "rofi -show combi -theme dracula-icon",
  auto_run = true,
}


M.config_editor = M.gui_editor .. rc_path

return M
