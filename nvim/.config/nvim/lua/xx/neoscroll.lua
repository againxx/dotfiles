local conditional_scroll = function(lines, ...)
  local hover = require "lspsaga.hover"
  local finder = require "lspsaga.provider"
  local direction = lines > 0 and 1 or -1

  if hover.has_saga_hover() then
    hover.scroll_in_hover(direction)
  elseif finder.has_saga_def_preview() then
    finder.scroll_in_def_preview(direction)
  else
    require('neoscroll').scroll(lines, ...)
  end
end

return conditional_scroll
