" ===
" === Yank & Paste
" ===
" map Y to yank to system clipboard in visual mode
xnoremap Y "+y

" alias r to ], a to >, same as surround.vim
onoremap ir i]
onoremap ar a]
onoremap ia i>
onoremap aa a>
vnoremap ir i]
vnoremap ar a]
vnoremap ia i>
vnoremap aa a>

" map gb to reselect previous yank text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Use <C-q> to repeat last macro
nnoremap <C-q> @@

" neovim native <C-c> seems to conflict with slime.vim, unbind <C-c> and move
" it into <C-c><C-x>
nnoremap <C-c> <nop>
nnoremap <C-c><C-x> <C-c>
nmap <C-c><C-l> <Plug>SlimeLineSend
nmap <C-c>l <Plug>SlimeLineSend

" Continuous indent
xnoremap < <gv
xnoremap > >gv

" Avoid join lines when begin visual line mode
xnoremap <expr> J line(".") == line("'<") ? "j" : "J"

" Up and Down are more intelligent in command line history navigation
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Make <C-j> and <C-k> move faster, in vim these two keys are used for window
" navigation
nnoremap <C-j> 5j
nnoremap <C-k> 5k
xnoremap <C-j> 5j
xnoremap <C-k> 5k

" Enhanced <C-l>, in vim this key is used for window navigation
nnoremap <C-l> :nohlsearch<CR>:<C-r>=has('diff')?'diffupdate':''<CR><CR>:syntax sync fromstart<CR>:pclose<CR><C-l>

" Fast normal mode
noremap <M-n> :normal!<Space>

" Fast substitute
nnoremap <M-s> :%s/
xnoremap <M-s> :s/

" exit terminal
tnoremap <C-o> <C-\><C-n>

" ===
" === Window Navigate
" ===
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
nnoremap <M-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <M-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <M-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <M-l> <Cmd>TmuxNavigateRight<CR>
nnoremap <M-p> <Cmd>TmuxNavigatePrevious<CR>

" ===
" === Command-line Cursor Movement
" ===
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>
cnoremap <M-k> <S-Left>
cnoremap <M-j> <S-Right>

" ===
" === Window Resize
" ===
nnoremap <M-=> 3<C-w>+
nnoremap <M--> 3<C-w>-
nnoremap <M-[> 5<C-w><
nnoremap <M-]> 5<C-w>>
nnoremap <M-+> <C-w>+
nnoremap <M-_> <C-w>-
nnoremap <M-{> <C-w><
nnoremap <M-}> <C-w>>
nnoremap <M-z> <Cmd>MaximizerToggle!<CR>
vnoremap <M-z> <Cmd>MaximizerToggle!<CR>gv
inoremap <M-z> <Cmd>MaximizerToggle!<CR>

nnoremap <M-9> <Cmd>QPrev<CR>
nnoremap <M-0> <Cmd>QNext<CR>

" ===
" === Window Split
" ===
nnoremap <C-w>l <Cmd>rightbelow vsplit<CR>
nnoremap <C-w>h <Cmd>leftabove vsplit<CR>
nnoremap <C-w>j <Cmd>rightbelow split<CR>
nnoremap <C-w>k <Cmd>leftabove split<CR>
nnoremap <C-w><C-l> <Cmd>rightbelow vsplit<CR>
nnoremap <C-w><C-h> <Cmd>leftabove vsplit<CR>
nnoremap <C-w><C-j> <Cmd>rightbelow split<CR>
nnoremap <C-w><C-k> <Cmd>leftabove split<CR>

" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Improve enter inside bracket `<> {} [] ()` by add new empty line below and place cursor to it.
" inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
" \   : \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
