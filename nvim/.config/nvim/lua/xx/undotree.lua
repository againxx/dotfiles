if vim.fn.has('persistent_undo') then
  vim.opt.undofile = true
  vim.g.undotree_SetFocusWhenToggle = 1
end
