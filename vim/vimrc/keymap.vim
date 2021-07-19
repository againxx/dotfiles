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

" Make <C-e> and <C-y> move faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Use w/b to move over chinese ci
nmap <silent> w <Plug>(coc-ci-w)
nmap <silent> b <Plug>(coc-ci-b)

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

" Temporary disable <Up> & <Down>
inoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
map <F1> <nop>
imap <F1> <nop>
" Avoid join lines when begin visual line mode
xnoremap <expr> J line(".") == line("'<") ? "j" : "J"

" Up and Down are more intelligent in command line history navigation
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Buffer navigation
nnoremap [b <Cmd>bprevious<CR>
nnoremap ]b <Cmd>bnext<CR>
nnoremap [B <Cmd>bfirst<CR>
nnoremap ]B <Cmd>blast<CR>

" Quickfix navigation
nnoremap [q <Cmd>cprevious<CR>
nnoremap ]q <Cmd>cnext<CR>
nnoremap [Q <Cmd>cfirst<CR>
nnoremap ]Q <Cmd>clast<CR>

" Vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vista
" Find symbol of current document.
nnoremap <silent> gO :<C-u>Vista!!<CR>

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
nmap y/ <Plug>(incsearch-fuzzy-/)
nmap y? <Plug>(incsearch-fuzzy-?)
nmap yg/ <Plug>(incsearch-fuzzy-stay)

nnoremap <C-_> <Cmd>call luaeval("require('telescope_config').current_buffer_fuzzy_find(_A)", expand('<cword>'))<CR>
nnoremap <C-p> <Cmd>lua require('telescope.builtin').live_grep()<CR>

" ===
" === Coc
" ===
" navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
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

" GoTo code navigation.
nnoremap gd <Cmd>Telescope coc definitions<CR>
nnoremap gl <Cmd>Telescope coc declarations<CR>
nnoremap gL <Cmd>Telescope coc implementations<CR>
nnoremap gr <Cmd>Telescope coc references<CR>
nnoremap gy <Cmd>Telescope coc type_definitions<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :<C-u>call <SID>ShowDocumentation()<CR>

" Use <Tab> for select text for visual placeholder of snippet.
" vmap <Tab> <Plug>(coc-snippets-select)
" imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-l> to expand ultisnips or save visual selected content
let g:UltiSnipsExpandTrigger = '<C-l>'

" Scroll floating window up and down
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)

" vimwiki
map <Plug>Disable_VimwikiGoto <Plug>VimwikiGoto

" ===
" === Table-mode
" ===
let g:table_mode_motion_left_map = '[t'
let g:table_mode_motion_right_map = ']t'
let g:table_mode_motion_up_map = '[T'
let g:table_mode_motion_down_map = ']T'

function! s:ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
