P = function(...)
  if vim.print then
    return vim.print(...)
  else
    local objects = {}
    for i = 1, select('#', ...) do
      local v = select(i, ...)
      table.insert(objects, vim.inspect(v))
    end
    print(table.concat(objects, '\n'))
    return ...
  end
end

R = function(name)
  require("plenary.reload").reload_module(name)
  return require(name)
end
