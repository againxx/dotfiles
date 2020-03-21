if !has('nvim') | finish | endif

set termguicolors   " Use gui color (true color) in terminal
" speed up
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog  = '/usr/bin/python3'
let g:node_host_prog = '~/.config/yarn/global//node_modules/neovim/bin/cli.js'
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
