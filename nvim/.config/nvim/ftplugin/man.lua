local find_less_indent_line = function(backward)
  return function()
    local _, num_space = vim.api.nvim_get_current_line():find "^%s+"
    num_space = num_space and num_space - 1 or 0
    vim.cmd [[normal m']] -- add previous position into jumplist
    if backward then
      vim.fn.search([[^\s\{,]] .. num_space .. [[}\w]], "wbe")
    else
      vim.fn.search([[^\s\{,]] .. num_space .. [[}\w]], "we")
    end
  end
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

local bufnr = vim.api.nvim_get_current_buf()

wk.add {
  { "[[", find_less_indent_line(true), buffer = bufnr, desc = "Previous less indent line" },
  { "]]", find_less_indent_line(false), buffer = bufnr, desc = "Next less indent line" },
  { "<space>/", [[/^\s\+\zs]], buffer = bufnr, desc = "Forward search option" },
}
