local conditional_scroll = function(lines, ...)
  local hover = require "lspsaga.hover"
  local finder = require "lspsaga.provider"
  local direction = lines > 0 and 1 or -1

  if hover.has_saga_hover() then
    hover.scroll_in_hover(direction)
  elseif finder.has_saga_def_preview() then
    finder.scroll_in_def_preview(direction)
  elseif _G.disable_neoscroll then
    if direction == 1 then
      local ctrl_f_key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
      vim.api.nvim_feedkeys(ctrl_f_key, 'n', false)
    else
      local ctrl_b_key = vim.api.nvim_replace_termcodes("<C-b>", true, false, true)
      vim.api.nvim_feedkeys(ctrl_b_key, 'n', false)
    end
  else
    require('neoscroll').scroll(lines, ...)
  end
end

return conditional_scroll
