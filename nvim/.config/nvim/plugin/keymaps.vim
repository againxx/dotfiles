" ===
" === Yank & Paste
" ===
" map Y to yank from the cursor to the end of line
nnoremap Y y$
" map Y to yank to system clipboard in visual mode
xnoremap Y "+y
" map yp to paste from system clipboard
nnoremap yp "+p
nnoremap yP "+P

" map z; to toggle fold
nnoremap z; za

" map ZA to :qa
nnoremap ZA <Cmd>qa!<CR>

" map gus to ~
nnoremap gus ~

" make cw work like dw
nmap cw dwi

" text object for parameter
onoremap i, <Cmd>execute "normal! ?[,(]\rwv/[,)]\rh"<CR>
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

" Use [a and ]a in visual mode to move selection up and down
xnoremap [a :<C-u>call <SID>MoveSelectedLines(-v:count1)<CR>
xnoremap ]a :<C-u>call <SID>MoveSelectedLines(v:count1)<CR>
" Move one line in normal mode
nnoremap [a <Cmd>execute 'move -1-'.v:count1<CR>==
nnoremap ]a <Cmd>execute 'move +'.v:count1<CR>==

" Add empty line
nnoremap [<Space> <Cmd>call <SID>AddEmptyLines(-v:count1)<CR>
nnoremap ]<Space> <Cmd>call <SID>AddEmptyLines(v:count1)<CR>

" Continuous indent
xnoremap < <gv
xnoremap > >gv

" Avoid join lines when begin visual line mode
xnoremap <expr> J line(".") == line("'<") ? "j" : "J"

" Up and Down are more intelligent in command line history navigation
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
" And use <C-j> and <C-k> for wildmenu navigation just like normal completion
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" Quickfix navigation
nnoremap [q <Cmd>cfirst<CR>
nnoremap ]q <Cmd>clast<CR>

" Make <C-j> and <C-k> move faster, in vim these two keys are used for window
" navigation
nnoremap <C-j> 5j
nnoremap <C-k> 5k
xnoremap <C-j> 5j
xnoremap <C-k> 5k

" Enhanced <C-l>, in vim this key is used for window navigation
nnoremap <C-l> :nohlsearch<CR>:<C-r>=has('diff')?'diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-l>

" Fast normal mode
noremap <M-n> :normal<Space>

" Fast substitute
nnoremap <M-s> :%s//g<Left><Left>
xnoremap <M-s> :s//g<Left><Left>

" exit terminal
tnoremap <C-o> <C-\><C-n>
" tnoremap <M-[> <C-\><C-n>
" tnoremap <M-[> <Esc>
" tnoremap <C-v><Esc> <Esc>

" ===
" === Window Navigate
" ===
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
let g:tmux_navigator_no_mappings = 1
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
nnoremap <M-=> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-[> <C-w><
nnoremap <M-]> <C-w>>
nnoremap <M-z> <Cmd>MaximizerToggle!<CR>
vnoremap <M-z> <Cmd>MaximizerToggle!<CR>gv
inoremap <M-z> <Cmd>MaximizerToggle!<CR>

nnoremap <M-9> <Cmd>cprevious<CR>
nnoremap <M-0> <Cmd>cnext<CR>

" ===
" === Window Split
" ===
nnoremap <C-w>l <Cmd>rightbelow vnew +set\ nobuflisted<CR>
nnoremap <C-w>h <Cmd>leftabove vnew +set\ nobuflisted<CR>
nnoremap <C-w>j <Cmd>rightbelow new +set\ nobuflisted<CR>
nnoremap <C-w>k <Cmd>leftabove new +set\ nobuflisted<CR>
nnoremap <C-w><C-l> <Cmd>rightbelow vnew +set\ nobuflisted<CR>
nnoremap <C-w><C-h> <Cmd>leftabove vnew +set\ nobuflisted<CR>
nnoremap <C-w><C-j> <Cmd>rightbelow new +set\ nobuflisted<CR>
nnoremap <C-w><C-k> <Cmd>leftabove new +set\ nobuflisted<CR>

" Vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim-markdown
" disable mapping for ge
map <Plug>Disable_Markdown_EditUrlUnderCursor <Plug>Markdown_EditUrlUnderCursor
map <Plug>Disable_Markdown_MoveToCurHeader <Plug>Markdown_MoveToCurHeader

" ===
" === Incsearch
" ===
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <Tab> to expand snippet or confirm completion
inoremap <silent> <Tab> <C-r>=<SID>ExpandUltisnipsOrUseCocCompletion()<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
" Improve enter inside bracket `<> {} [] ()` by add new empty line below and place cursor to it.
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
\   : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" vimwiki
map <Plug>Disable_VimwikiGoto <Plug>VimwikiGoto

" ===
" === Table-mode
" ===
let g:table_mode_motion_left_map = '[t'
let g:table_mode_motion_right_map = ']t'
let g:table_mode_motion_up_map = '[T'
let g:table_mode_motion_down_map = ']T'

function! s:ExpandUltisnipsOrUseCocCompletion() abort
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res > 0
    pclose
    return ''
  " Use `complete_info` if your (Neo)Vim version supports it.
  elseif (has('patch8.1.1068') && complete_info()['selected'] != '-1') ||
    \  pumvisible()
    return "\<C-y>"
  else
    return "\<C-g>u\<Tab>"
  endif
endfunction

function! s:AddEmptyLines(count) abort
  let cursor_pos = getcurpos()[1:]
  if a:count < 0
    put! =repeat(nr2char(10), -a:count)
    let cursor_pos[0] -= a:count
  else
    put =repeat(nr2char(10), a:count)
  endif
  call cursor(cursor_pos)
endfunction

function! s:MoveSelectedLines(count) abort
  if a:count == -1
    execute "'<,'>move '<-2"
  elseif a:count == 1
    execute "'<,'>move '>+"
  elseif a:count < -1
    execute "normal! gv\<Esc>"
    let move_dist = line('.') - line("'<") + a:count
    execute "'<,'>move '<" . move_dist
  else
    execute "normal! gv\<Esc>"
    let move_dist = line("'>") - line('.') + a:count
    execute "'<,'>move '>+" . move_dist
  endif
  normal! gv=gv
endfunction
