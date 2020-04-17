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

" text object for parameter
onoremap i, :<C-u>execute "normal! ?[,(]\rwv/[,)]\rh"<CR>
nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" map gb to reselect previous yank text
nnoremap <expr> gb '`['.strpart(getregtype(),0, 1).'`]'

" Make <C-e> and <C-y> move faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" Make <C-j> and <C-k> move faster
nnoremap <C-j> 5j
nnoremap <C-k> 5k

" When close window, reset nosplitright & nosplitbelow
nnoremap <silent> <C-w>c :set nosplitright<CR>:set nosplitbelow<CR><C-w>c

" Use [a and ]a in visual mode to move selection up and down
xnoremap [a :<c-u>execute "'<,'>move '<-1-".v:count1<CR>gv=gv
xnoremap ]a :<c-u>execute "'<,'>move '>+".v:count1<CR>gv=gv
" Move line in normal mode
nnoremap [a :<c-u>execute 'move -1-'.v:count1<CR>
nnoremap ]a :<c-u>execute 'move +'.v:count1<CR>

" Add empty line
nnoremap [<space> ma:<c-u>put! =repeat(nr2char(10), v:count1)<CR>`a
nnoremap ]<space> ma:<c-u>put =repeat(nr2char(10), v:count1)<CR>`a

" Continuous indent
xnoremap < <gv
xnoremap > >gv

" Temporary disable <Backspace> & <Up> & <Down>
inoremap <BS> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
map <F1> <nop>
imap <F1> <nop>
" Avoid join lines when begin visual line mode
xnoremap <expr> J line(".") == line("'<") ? "j" : "J"

" Buffer navigation
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" NERDTree
" map <F2> :NERDTreeToggle<CR>

" Terminal
nnoremap <space>x :terminal<CR>


" Vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ===
" === Incsearch
" ===
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nmap y/ <Plug>(incsearch-fuzzy-/)
nmap y? <Plug>(incsearch-fuzzy-?)
nmap yg/ <Plug>(incsearch-fuzzy-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" ===
" === Ale
" ===
" Use `[e\[w` and `]e\]w` to navigate diagnostics
nmap <silent> [e <Plug>(ale_previous_wrap_error)
nmap <silent> ]e <Plug>(ale_next_wrap_error)
nmap <silent> [w <Plug>(ale_previous_wrap_warning)
nmap <silent> ]w <Plug>(ale_next_wrap_warning)
" nmap <silent> [g <Plug>(ale_previous_wrap)
" nmap <silent> ]g <Plug>(ale_next_wrap)
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" ===
" === Coc
" ===
" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" Use <Tab> to confirm completion
if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <Tab> complete_info()["selected"] != "-1" ? "\<C-y>" :
    \   coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :   
    \   "\<C-g>u\<Tab>"
else
    inoremap <expr> <Tab> pumvisible() ? "\<C-y>" :
    \   coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :   
    \   "\<C-g>u\<Tab>"
endif
" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
" Improve enter inside bracket `<> {} [] ()` by add new empty line below and place cursor to it.
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
\   : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gl <Plug>(coc-declration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <Tab> for select text for visual placeholder of snippet.
vmap <Tab> <Plug>(coc-snippets-select)
" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Scroll floating window up and down
nnoremap <expr><C-n> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-n>"
nnoremap <expr><C-p> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-p>"

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" coc-lists
nnoremap <silent> <space>m :<C-u>CocList -N mru -A<cr>
nnoremap <silent> <space>f :<C-u>CocList files<cr>
nnoremap <silent> <space>b :<C-u>CocList buffers<cr>
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
" Search coc commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Search vim commands
nnoremap <silent> <space>v :<C-u>CocList vimcommands<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>s :<C-u>Vista finder<cr>
nnoremap <silent> <space>S :<C-u>CocList --normal sources<cr>
nnoremap <silent> <space>r :<C-u>CocListResume<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>Vista!!<cr>
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Show locationlist
nnoremap <silent> <space>l :<C-u>CocList --normal locationlist<cr>
nnoremap <silent> <space>q :<C-u>CocList --normal quickfix<cr>
nnoremap <silent> <space>h :<C-u>CocList helptags<cr>
nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<cr>
nnoremap <silent> <space>u :<C-u>UndotreeToggle<cr>
nnoremap <silent> <space>t :<C-u>CocList --normal todolist<cr>
nnoremap <silent> <space>K :<C-u>CocList maps<cr>
nnoremap <silent> <space>p :<C-u>CocList grep<cr>
nnoremap <silent> <space>P :<C-u>CocList snippets<cr>
nnoremap <silent> <space>j :<C-u>CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocPrev<cr>
nnoremap <silent> <space>e :<C-u>CocCommand explorer<cr>
nnoremap <silent> <space>' :<C-u>CocList --normal marks<cr>
" nnoremap <silent> <space>w :exe 'CocList -I --normal --input='.expand('<cword>').' grep'<CR>

function! s:toggleVista()
    if vista#sidebar#IsOpen()
        execute "Vista!"
        if &showtabline != 2
            set showtabline=2
        endif
        call lightline#update()
    else
        execute "Vista"
    endif
endfunction

" ===
" === Whichkey
" ===
let g:which_wikilist_lower_map =  {}
let g:which_wikilist_lower_map.r = 'renumber-current'
let g:which_wikilist_lower_map.l = 'increase-item-level'
let g:which_wikilist_lower_map.h = 'decrease-item-level'
let g:which_wikilist_lower_map.n = 'increase-checkbox-done'
let g:which_wikilist_lower_map.p = 'decrease-checkbox-done'
let g:which_wikilist_lower_map.t = 'remove-item-checkbox'
let g:which_wikilist_lower_map.x = 'toggle-checkbox-disabled'
let g:which_wikilist_lower_map['*'] = 'make_*_list/change_item_*'
let g:which_wikilist_lower_map['-'] = 'make_-_list/change_item_-'
let g:which_wikilist_lower_map['+'] = 'make_+_list/change_item_+'
let g:which_wikilist_lower_map['1'] = 'make_1_lsit/change_item_num'
let g:which_wikilist_upper_map =  {}
let g:which_wikilist_upper_map.r = 'renumber-all'
let g:which_wikilist_upper_map.R = 'renumber-all'
let g:which_wikilist_upper_map.l = 'increase-list-level'
let g:which_wikilist_upper_map.L = 'increase-list-level'
let g:which_wikilist_upper_map.h = 'decrease-list-level'
let g:which_wikilist_upper_map.H = 'decrease-list-level'
let g:which_wikilist_upper_map.t = 'remove-list-checkbox'
let g:which_wikilist_upper_map['*'] = 'change_list_*'
let g:which_wikilist_upper_map['-'] = 'change_list_-'
let g:which_wikilist_upper_map['+'] = 'change_list_+'
let g:which_wikilist_upper_map['1'] = 'change_list_num'
