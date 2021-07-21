vim.fn.setenv('FZF_PREVIEW_PREVIEW_BAT_THEME', 'Dracula')
vim.fn.setenv('FZF_DEFAULT_OPTS', '--reverse --bind ctrl-f:preview-page-down,ctrl-b:preview-page-up')
vim.g.fzf_layout = {
  window = {
      width = 0.9,
      height = 0.9,
      xoffset = 0.5,
      border = 'rounded'
  }
}
vim.g.fzf_preview_window = { 'up:60%', 'ctrl-/' }
