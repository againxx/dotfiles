if !has('nvim') | finish | endif

set inccommand=nosplit
if has("persistent_undo")
    set undofile
    if !isdirectory($HOME . '/.config/nvim/tmp/undo')
        call mkdir($HOME . "/.config/nvim/tmp/undo", "p")
    endif
    set undodir=$HOME/.config/nvim/tmp/undo
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
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-p> :TmuxNavigatePrevious<cr>

" ===
" === Window Resize
" ===
nnoremap <M-=> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>

" ===
" === Window Split
" ===
nnoremap <C-w>l :set splitright<CR>:vsplit<CR>
nnoremap <C-w>h :set nosplitright<CR>:vsplit<CR>
nnoremap <C-w>j :set splitbelow<CR>:split<CR>
nnoremap <C-w>k :set nosplitbelow<CR>:split<CR>

" Fast normal mode
noremap <M-n> :normal<Space>

" ===
" === Buffer Navigation
" ===
nmap <M-1> <Plug>lightline#bufferline#go(1)
nmap <M-2> <Plug>lightline#bufferline#go(2)
nmap <M-3> <Plug>lightline#bufferline#go(3)
nmap <M-4> <Plug>lightline#bufferline#go(4)
nmap <M-5> <Plug>lightline#bufferline#go(5)
nmap <M-6> <Plug>lightline#bufferline#go(6)
" Use <M-j> for jump to next placeholder and <M-k> for jump to previous placeholder
let g:coc_snippet_next = '<M-j>'
let g:coc_snippet_prev = '<M-k>'
