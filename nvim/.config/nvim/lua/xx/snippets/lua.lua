---@diagnostic disable:undefined-global
local snippets = {
  s("req", fmt('local {} = require("{}")', {
    f(function (values)
      local value = values[1][1]
      local path = vim.split(value, "%.")
      return path[#path]
    end, { 1 }),
    i(1),
  }))
}

return snippets
