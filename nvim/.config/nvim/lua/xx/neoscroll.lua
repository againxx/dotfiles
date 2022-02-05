local conditional_scroll = function(lines, ...)
  -- if vim.fn['coc#float#has_scroll']() > 0 then
  --   vim.fn['coc#float#scroll'](lines > 0 and 1 or 0)
  -- else
  require('neoscroll').scroll(lines, ...)
  -- end
end

return conditional_scroll
