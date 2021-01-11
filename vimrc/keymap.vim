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
nnoremap ZA :qa!<CR>

" map gus to ~
nnoremap gus ~

" text object for parameter
onoremap i, :<C-u>execute "normal! ?[,(]\rwv/[,)]\rh"<CR>
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

" Use [a and ]a in visual mode to move selection up and down
xnoremap [a :<c-u>execute "'<,'>move '<-1-".v:count1<CR>gv=gv
xnoremap ]a :<c-u>execute "'<,'>move '>+".v:count1<CR>gv=gv
" Move line in normal mode
nnoremap [a :<c-u>execute 'move -1-'.v:count1<CR>==
nnoremap ]a :<c-u>execute 'move +'.v:count1<CR>==

" Add empty line
nnoremap [<space> ma:<c-u>put! =repeat(nr2char(10), v:count1)<CR>`a
nnoremap ]<space> ma:<c-u>put =repeat(nr2char(10), v:count1)<CR>`a

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
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" Quickfix navigation
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" Terminal
nnoremap <space>x :terminal<CR>

" Vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim-markdown
" disable mapping for ge
map <Plug>Disable_Markdown_EditUrlUnderCursor <Plug>Markdown_EditUrlUnderCursor
map <Plug>Disable_Markdown_MoveToCurHeader <Plug>Markdown_MoveToCurHeader

" Disable sneak ; & ,
map <Plug>Disable_Sneak_; <Plug>Sneak_;
map <Plug>Disable_Sneak_, <Plug>Sneak_,

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

" ===
" === Ale
" ===
" Use [e \ [w and ]e \ ]w to navigate diagnostics
nmap <silent> [e <Plug>(ale_previous_wrap_error)
nmap <silent> ]e <Plug>(ale_next_wrap_error)
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

" ===
" === Coc
" ===
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <Tab> to expand snippet or confirm completion
inoremap <silent> <Tab> <C-r>=<SID>expandUltisnipsOrUseCocCompletion()<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
" Improve enter inside bracket `<> {} [] ()` by add new empty line below and place cursor to it.
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
\   : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gl <Plug>(coc-declration)
nmap <silent> gL <Plug>(coc-implementation)
nmap <silent> gr :CocCommand fzf-preview.CocReferences<cr>
nmap <silent> gR <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>showDocumentation()<CR>

" Use <Tab> for select text for visual placeholder of snippet.
" vmap <Tab> <Plug>(coc-snippets-select)
" imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-l> to expand ultisnips or save visual selected content
let g:UltiSnipsExpandTrigger = "<C-l>"

" Scroll floating window up and down
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" coc-lists
nnoremap <silent> <space>m :<C-u>CocCommand fzf-preview.MruFiles<cr>
nnoremap <silent> <space>f :<C-u>CocList files<cr>
nnoremap <silent> <space>b :<C-u>CocList buffers<cr>
nnoremap <silent> <space><C-b> :<C-u>let g:fzf_preview_fzf_preview_window_option='right:70%'<bar>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <space>Y :<C-u>CocList --normal sources<cr>
" Search coc commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
nnoremap <silent> <space>C :<C-u>CocCommand fzf-preview.CommandPalette<cr>
" Search vim commands
nnoremap <silent> <space>v :<C-u>CocList vimcommands<cr>
" Search workspace symbols.
nnoremap <silent> <space>s :<C-u>Vista finder<cr>
nnoremap <silent> <space>S :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>. :<C-u>CocListResume<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>Vista!!<cr>
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Show locationlist
nnoremap <silent> <space>l :<C-u>CocList --normal locationlist<cr>
nnoremap <silent> <space><C-l> :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> <space>q :<C-u>CocList --normal quickfix<cr>
nnoremap <silent> <space><C-q> :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> <space>h :<C-u>CocList helptags<cr>
nnoremap <silent> <space>u :<C-u>UndotreeToggle<cr>
nnoremap <silent> <space>D :<C-u>CocList --normal todolist<cr>
nnoremap <silent> <space>K :<C-u>CocList maps<cr>
nnoremap <silent> <space>p :<C-u>CocList grep<cr>
nnoremap <silent> <space>P :<C-u>set operatorfunc=<SID>grepFromSelected<CR>g@
vnoremap <silent> <space>P :<C-u>call <SID>grepFromSelected(visualmode())<CR>
nnoremap <silent> <space>j :<C-u>CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocPrev<cr>
nnoremap <silent> <space>H :<C-u>CocFirst<cr>
nnoremap <silent> <space>L :<C-u>CocLast<cr>
nnoremap <silent> <space>e :<C-u>CocCommand explorer<cr>
nnoremap <silent> <space>' :<C-u>CocCommand fzf-preview.Marks<cr>
nnoremap <silent> <space>" :<C-u>CocList marks<cr>
nnoremap <silent> <space>g/ :<C-u>CocList searchhistory<cr>
nnoremap <silent> <space>t :<C-u>CocList tasks<cr>
nnoremap <silent> <space><C-f> :<C-u>let g:fzf_preview_fzf_preview_window_option='right:70%'<bar>CocCommand fzf-preview.GitFiles<cr>
nnoremap <silent> <space><C-p> :<C-u>Rg<cr>
nnoremap <silent> <space><C-g> :<C-u>tabe<bar>term lazygit<cr>a
nnoremap <silent> <space><C-o> :<C-u>CocCommand fzf-preview.Jumps<cr>
nnoremap <silent> <space>g; :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> <space>/ :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--query="'"<cr>
nnoremap <silent> <space>? :<C-u>CocCommand fzf-preview.BufferLines<cr>
nnoremap <silent> <space>* :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<cr>"<cr>
nnoremap <silent> <space>gs :<C-u>let g:fzf_preview_fzf_preview_window_option='right:70%'<bar>CocCommand fzf-preview.GitStatus<cr>
" show chunk diff at current position
nmap <silent> <space>gd <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <silent> <space>gc <Plug>(coc-git-commit)
nnoremap <silent> <space>ga :<C-u>CocCommand git.chunkStage<cr>
nnoremap <silent> <space>gu :<C-u>CocCommand git.chunkUndo<cr>
nnoremap <silent> <space>gz :<C-u>CocCommand git.foldUnchanged<cr>
nnoremap <silent> <space>gr :<C-u>Git restore --staged %<bar>CocCommand git.refresh<cr>
" nnoremap <silent> <space>w :exe 'CocList -I --normal --input='.expand('<cword>').' grep'<CR>

" vimwiki
map <Plug>Disable_VimwikiGoto <Plug>VimwikiGoto

" ===
" === Vimspector
" ===
nnoremap <space>dd :call vimspector#Launch()<cr>
nnoremap <space>d$ :call vimspector#Reset()<cr>
nnoremap <space>dc :call <SID>gotoWindowAndMaximize(g:vimspector_session_windows.code)<cr>
nnoremap <space>dv :call <SID>gotoWindowAndMaximize(g:vimspector_session_windows.variables)<cr>
nnoremap <space>dw :call <SID>gotoWindowAndMaximize(g:vimspector_session_windows.watches)<cr>
nnoremap <space>ds :call <SID>gotoWindowAndMaximize(g:vimspector_session_windows.stack_trace)<cr>
nnoremap <space>do :call <SID>gotoWindowAndMaximize(g:vimspector_session_windows.output)<cr>

nmap <space>dl <Plug>VimspectorStepInto
nmap <space>dj <Plug>VimspectorStepOver
nmap <space>dk <Plug>VimspectorStepOut
nmap <space>dh <Plug>VimspectorRunToCursor
nmap <space>d_ <Plug>VimspectorRestart
nmap <space>de <Plug>VimspectorContinue
nmap <space>d; <Plug>VimspectorToggleBreakpoint
nmap <space>di <Plug>VimspectorToggleConditionalBreakpoint

nnoremap <space>dx :call vimspector#ClearBreakpoints()<cr>

" ===
" === refactor/run tasks
" ===
nnoremap <silent> <space>ra :<C-u>RnvimrToggle<cr>
" Formatting selected code.
xmap <space>rf <Plug>(coc-format-selected)
nmap <space>rf <Plug>(coc-format-selected)
" nmap <space>rf <Plug>(coc-refactor)
" Apply AutoFix to problem on the current line.
nmap <space>rx <Plug>(coc-fix-current)
" Apply ALEFix for the whole buffer
nmap <space>rX <Plug>(ale_fix)
" Symbol renaming.
nmap <space>rn <Plug>(coc-rename)
nnoremap <silent> <space>rr :AsyncTask file-run<CR>
" exec in terminal
augroup spacemap_augroup
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <space>rp :AsyncTask project-run<CR>
    autocmd FileType cpp nnoremap <buffer> <space>rb :AsyncTask project-build<CR>
    autocmd FileType cpp nnoremap <buffer> <space>rB :AsyncTask file-build<CR>
    autocmd FileType cpp nnoremap <buffer> <space>ri :AsyncTask project-init<CR>
    autocmd FileType cpp nnoremap <buffer> <space>rc :AsyncTask project-clean<CR>
    autocmd FileType cpp nnoremap <buffer> <space>rF :ALEFix clang-format<CR>
    autocmd FileType cpp nnoremap <buffer> <space>rX :ALEFix clangtidy<CR>
    autocmd FileType python nnoremap <buffer> <silent> <space>rr :CocCommand python.execInTerminal<CR>
    autocmd FileType python xnoremap <buffer> <silent> <space>rs :CocCommand python.execSelectionInTerminal<CR>
augroup END

" ===
" === Whichkey
" ===
nnoremap <silent> <space> :<C-u>WhichKey '<space>'<CR>
vnoremap <silent> <space> :<C-u>WhichKeyVisual '<space>'<CR>

" For vimwiki
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
let g:which_wikilist_lower_map['1'] = 'make_1_list/change_item_num'
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
let g:which_wikilist_upper_map['1'] = 'change_list_num'

" For coc-lists
let g:which_space_map = {}
let g:which_space_map.m = 'most-recent-used'
let g:which_space_map.f = 'file'
let g:which_space_map.b = 'buffer'
let g:which_space_map.y = 'yank'
let g:which_space_map.Y = 'source'
let g:which_space_map.c = 'coc-command'
let g:which_space_map.C = 'command-history'
let g:which_space_map.v = 'vim-command'
let g:which_space_map.s = 'vista'
let g:which_space_map.S = 'coc-symbol'
let g:which_space_map.o = 'outline'
let g:which_space_map.a = 'diagnostic'
let g:which_space_map.l = 'location-list'
let g:which_space_map.q = 'quickfix'
let g:which_space_map.h = 'help'
let g:which_space_map.u = 'undo-tree'
let g:which_space_map.D = 'todo-list'
let g:which_space_map.K = 'key-map'
let g:which_space_map.p = 'grep'
let g:which_space_map.P = 'grep-by-motion'
let g:which_space_map.j = 'next-item'
let g:which_space_map.k = 'previous-item'
let g:which_space_map.H = 'first-item'
let g:which_space_map.L = 'last-item'
let g:which_space_map.e = 'explorer'
let g:which_space_map.t = 'task'
let g:which_space_map.x = 'open-terminal'
let g:which_space_map['<C-F>'] = 'git-file'
let g:which_space_map['<C-P>'] = 'fzf-grep'
let g:which_space_map['<C-B>'] = 'buffer-project-mru'
let g:which_space_map['<C-L>'] = 'location-list-preview'
let g:which_space_map['<C-Q>'] = 'quickfix-preview'
let g:which_space_map['<C-G>'] = 'lazygit'
let g:which_space_map['<C-O>'] = 'jump-location'
let g:which_space_map['.'] = 'last-list'
let g:which_space_map['/'] = 'line-in-current-buffer'
let g:which_space_map['?'] = 'line-in-all-buffer'
let g:which_space_map["'"] = 'mark-preview'
let g:which_space_map['"'] = 'mark'
let g:which_space_map['*'] = 'grep-current-word'

" For git/go-to-line
let g:which_space_map.g = {
\   'name': '+git/history',
\   '/':    'search-history',
\   ';':    'change-history',
\   's':    'show-git-status',
\   'd':    'show-chunk-diff',
\   'c':    'show-commit-contains-current-line',
\   'a':    'stage-chunk',
\   'u':    'undo-chunk',
\   'z':    'fold-unchanged',
\   'r':    'restore-current-file',
\ }

" For refactor/run
let g:which_space_map.r = {
\   'name': '+refactor/run',
\   'a':    'ranger',
\   'n':    'rename',
\   'f':    'format-selected',
\   'F':    'format-buffer',
\   'x':    'fix-line',
\   'X':    'fix-buffer',
\   's':    'run-selected',
\   'p':    'run-project',
\   'r':    'run-current-file',
\   'b':    'build-project',
\   'B':    'build-file',
\   'i':    'init-project',
\   'c':    'clean',
\ }

" For vimspector
let g:which_space_map.d = {
\   'name': '+debug',
\   'd':    'start',
\   '$':    'stop',
\   'c':    'browse-code',
\   'v':    'browse-variables',
\   'w':    'browse-watches',
\   's':    'browse-stack-trace',
\   'o':    'browse-output',
\   'l':    'step-into',
\   'j':    'step-over',
\   'k':    'step-out',
\   'h':    'run-to-cursor',
\   '_':    'restart',
\   'e':    'continue',
\   ';':    'toggle-breakpoint',
\   'i':    'toggle-conditional-breakpoint',
\   'x':    'clear-all-breakpoints',
\ }

function! s:gotoWindowAndMaximize(win_id) abort
    call win_gotoid(a:win_id)
    execute 'MaximizerToggle'
endfunction

function! s:showDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:expandUltisnipsOrUseCocCompletion() abort
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res > 0
        pclose
        return ""
    " Use `complete_info` if your (Neo)Vim version supports it.
    elseif (has('patch8.1.1068') && complete_info()["selected"] != "-1") ||
        \   pumvisible()
        return "\<C-y>"
    else
        return "\<C-g>u\<Tab>"
    endif
endfunction

function! s:grepFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocCommand fzf-preview.ProjectGrep '.word
endfunction
