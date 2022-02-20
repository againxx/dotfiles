-- add < into autopairs
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("<", ">", "rust"):with_move(function(opts)
  if opts.char == ">" then
    return true
  end
  return false
end))
