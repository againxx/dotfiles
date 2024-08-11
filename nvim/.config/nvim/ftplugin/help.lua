local success, wk = pcall(require, "which-key")
if not success then
  return
end

vim.opt_local.colorcolumn = ""

local bufnr = vim.api.nvim_get_current_buf()

wk.add {
  { "<A-i>", "<cmd>call search('<Bar>.\\{-}<Bar>', 'w')<cr>", buffer = bufnr, desc = "Go to next tag" },
  { "<A-o>", "<cmd>call search('<Bar>.\\{-}<Bar>', 'wb')<cr>", buffer = bufnr, desc = "Go to previous tag" },
  { "[t", "<cmd>call search('<Bar>.\\{-}<Bar>', 'wb')<cr>", buffer = bufnr, desc = "Go to previous tag" },
  { "]t", "<cmd>call search('<Bar>.\\{-}<Bar>', 'w')<cr>", buffer = bufnr, desc = "Go to next tag" },
}
