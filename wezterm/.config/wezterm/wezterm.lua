local wezterm = require "wezterm"

local font_with_fallback = function(name, params)
  local names = {name, "PingFang SC"}
  return wezterm.font_with_fallback(names, params)
end

return {
  set_environment_variables = {
    ZSH_TMUX_AUTOSTART = "true",
  },
  -- don't spawn login shell
  default_prog = {"/usr/bin/zsh"},
  font = font_with_fallback("VictorMono Nerd Font"),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback("VictorMono Nerd Font", {italic = true, weight = "Medium"}),
    }
  },
  font_size = 10.0,
  window_background_opacity = 0.9,
  enable_tab_bar = false,
  colors = {
      -- The default text color
      foreground = "#cbccc6",
      -- The default background color
      background = "#1f2430",

      -- Overrides the cell background color when the current cell is occupied by the
      -- cursor and the cursor style is set to Block
      cursor_bg = "#ffee99",
      -- Overrides the text color when the current cell is occupied by the cursor
      cursor_fg = "#191e2a",
      -- Specifies the border color of the cursor when the cursor style is set to Block,
      -- of the color of the vertical or horizontal bar when the cursor style is set to
      -- Bar or Underline.
      cursor_border = "#ffee99",

      -- the foreground color of selected text
      selection_fg = "#191e2a",
      -- the background color of selected text
      selection_bg = "#33415e",

      -- The color of the scrollbar "thumb"; the portion that represents the current viewport
      scrollbar_thumb = "#222222",

      -- The color of the split lines between panes
      split = "#444444",

      ansi = {"#191e2a", "#ed8274", "#a6cc70", "#fad07b", "#6dcbfa", "#a37acc", "#90e1c6", "#c7c7c7"},
      brights = {"#686868", "#f28779", "#bae67e", "#ffd580", "#73d0ff", "#d4bfff", "#95e6cb", "#fafafa"},
  },
  disable_default_key_bindings = true,
  keys = {
    { key="v", mods="CTRL|SHIFT", action=wezterm.action{ PasteFrom="Clipboard" } },
    { key="c", mods="CTRL|SHIFT", action=wezterm.action{ CopyTo="Clipboard" } },
  }
}
