vim.g.vimtex_quickfix_mode = 0

vim.api.nvim_buf_set_keymap(0, '', 'K', '<Plug>(vimtex-doc-package)', { noremap = false })

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register({
  name = "+latex",
  i = { "<Plug>(vimtex-info)", "Information about current project" },
  I = { "<Plug>(vimtex-info-full)", "Information about all projects" },
  t = { "<Plug>(vimtex-toc-open)", "Open table of contents" },
  T = { "<Plug>(vimtex-toc-toggle)", "Toggle table of contents" },
  q = { "<Plug>(vimtex-log)", "Show message log" },
  v = { "<Plug>(vimtex-view)", "View pdf" },
  r = { "<Plug>(vimtex-reverse-search)", "Reverse search" },
  l = { "<Plug>(vimtex-compile)", "Toggle compiler" },
  L = { "<Plug>(vimtex-compile)", "Compile selected part" },
  k = { "<Plug>(vimtex-stop)", "Stop compilation" },
  K = { "<Plug>(vimtex-stop)", "Stop compilation of all projects" },
  e = { "<Plug>(vimtex-errors)", "Open quickfix for errors/warnings" },
  o = { "<Plug>(vimtex-compile-output)", "Open file redirected by compiler output" },
  g = { "<Plug>(vimtex-status)", "Show compilation status" },
  G = { "<Plug>(vimtex-status-all)", "Show compilation status for all projects" },
  c = { "<Plug>(vimtex-clean)", "Clean auxiliary files" },
  C = { "<Plug>(vimtex-clean-full)", "Clean auxiliary/output files" },
  m = { "<Plug>(vimtex-imaps-list)", "Show list of insert mappings" },
  x = { "<Plug>(vimtex-reload)", "Reload VimTeX scripts" },
  X = { "<Plug>(vimtex-reload-state)", "Reload state for current buffer" },
  s = { "<Plug>(vimtex-toggle-main)", "Toggle main file" },
  a = { "<Plug>(vimtex-context-menu)", "Show context menu" },
}, {
  prefix = "-l",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  name = "+latex",
  L = { "<Plug>(vimtex-compile)", "Compiler" },
}, {
  mode = "x",
  prefix = "-l",
  buffer = vim.api.nvim_get_current_buf(),
})
