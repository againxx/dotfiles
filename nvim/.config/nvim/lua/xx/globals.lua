P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  require("plenary.reload").reload_module(name)
  return require(name)
end
