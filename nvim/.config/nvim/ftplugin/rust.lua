-- add < into autopairs
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.add_rule(Rule("<", ">", "rust"):with_move(function(opts)
  if opts.char == ">" then
    return true
  end
  return false
end))
