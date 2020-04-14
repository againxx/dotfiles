if !has('nvim') | finish | endif

set termguicolors   " Use gui color (true color) in terminal
set inccommand=nosplit
if has("persistent_undo")
    set undodir=~/.config/nvim/tmp/undo
    set undofile
endif

" speed up
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog  = '/usr/bin/python3'
let g:node_host_prog = '~/.config/yarn/global/node_modules/neovim/bin/cli.js'
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" exit terminal
tnoremap <M-[> <C-\><C-n>
" tnoremap <M-[> <Esc>
" tnoremap <C-v><Esc> <Esc>

" ===
" === Window Navigate
" ===
tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l
nnoremap <M-l> <c-w>l
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k

" ===
" === Buffer Navigation
" ===
nmap <M-1> <Plug>lightline#bufferline#go(1)
nmap <M-2> <Plug>lightline#bufferline#go(2)
nmap <M-3> <Plug>lightline#bufferline#go(3)
nmap <M-4> <Plug>lightline#bufferline#go(4)
nmap <M-5> <Plug>lightline#bufferline#go(5)
nmap <M-6> <Plug>lightline#bufferline#go(6)
