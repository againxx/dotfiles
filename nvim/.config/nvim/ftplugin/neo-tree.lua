local bufnr = vim.api.nvim_get_current_buf()

if vim.o.guicursor ~= "n:NeotreeCursorHiddenCursor" then
  _G.NeotreeSavedCursor = vim.o.guicursor
end

vim.api.nvim_create_autocmd("BufHidden", {
  buffer = bufnr,
  callback = function()
    require'bufferline.api'.set_offset(0)
  end
})
