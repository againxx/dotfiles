-- remove redundant angle brackets when completing header files
local cmp = require('cmp')
cmp.event:on('confirm_done', function()
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  if string.find(line, "#include") then
    local consecutive_chars = line:sub(cursor[2], cursor[2] + 1)
    if consecutive_chars == '>>' or consecutive_chars == '""' then
      local key = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
      vim.api.nvim_feedkeys(key, 'n', true)
    end
  end
end)
