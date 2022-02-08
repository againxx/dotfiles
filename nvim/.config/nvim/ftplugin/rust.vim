" call coc#config('codeLens.enable', 1)
if g:colors_name ==# 'ayu'
  hi LspRustTypeHint guifg=#7f709f guibg=NONE
  " hi CocRustTypeHint guifg=#9893bf guibg=NONE
endif

" add < into autopairs
lua << EOF
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.add_rule(Rule("<", ">", "rust"):with_move(function(opts)
  if opts.char == ">" then
    return true
  end
  return false
end))
EOF
