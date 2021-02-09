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
xnoremap [a :<C-u>call <SID>MoveSelectedLines(-v:count1)<CR>
xnoremap ]a :<C-u>call <SID>MoveSelectedLines(v:count1)<CR>
" Move one line in normal mode
nnoremap [a :<C-u>execute 'move -1-'.v:count1<CR>==
nnoremap ]a :<C-u>execute 'move +'.v:count1<CR>==

" Add empty line
nnoremap [<Space> :<C-u>call <SID>AddEmptyLines(-v:count1)<CR>
nnoremap ]<Space> :<C-u>call <SID>AddEmptyLines(v:count1)<CR>

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
nnoremap <Space>x :terminal<CR>

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
" nmap <silent> [e <Plug>(ale_previous_wrap_error)
" nmap <silent> ]e <Plug>(ale_next_wrap_error)
" nmap <silent> [w <Plug>(ale_previous_wrap)
" nmap <silent> ]w <Plug>(ale_next_wrap)

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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gl <Plug>(coc-declration)
nmap <silent> gL <Plug>(coc-implementation)
nmap <silent> gr :<C-u>CocCommand fzf-preview.CocReferences<CR>
nmap <silent> gR <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

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
" coc-lists
nnoremap <silent> <Space>m :<C-u>CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent> <Space>F :<C-u>Clap filer<CR>
nnoremap <silent> <Space>f :<C-u>Clap files --hidden<CR>
nnoremap <silent> <Space>b :<C-u>Clap buffers<CR>
nnoremap <silent> <Space><C-b> :<C-u>CocCommand fzf-preview.FromResources buffer project_mru --add-fzf-arg=--preview-window="right:70%"<CR>
nnoremap <silent> <Space>y :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <Space>Y :<C-u>CocList --normal sources<CR>
" Search coc commands
nnoremap <silent> <Space>cc :<C-u>CocList commands<CR>
" Search vim commands
nnoremap <silent> <Space>cv :<C-u>Clap command<CR>
nnoremap <silent> <Space>ch :<C-u>CocCommand fzf-preview.CommandPalette<CR>
" Search workspace symbols.
nnoremap <silent> <Space>s :<C-u>Vista finder<CR>
nnoremap <silent> <Space>S :<C-u>CocList -I symbols<CR>
nnoremap <silent> <Space>. :<C-u>CocListResume<CR>
" Show all diagnostics.
nnoremap <silent> <Space>a :<C-u>CocList diagnostics<CR>
nnoremap <silent> <Space><C-a> :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
" Show locationlist
nnoremap <silent> <Space>l :<C-u>CocList --normal locationlist<CR>
nnoremap <silent> <Space><C-l> :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> <Space>q :<C-u>CocList --normal quickfix<CR>
nnoremap <silent> <Space><C-q> :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> <Space>h :<C-u>CocList helptags<CR>
nnoremap <silent> <Space>u :<C-u>UndotreeToggle<CR>
nnoremap <silent> <Space>D :<C-u>CocList --normal todolist<CR>
nnoremap <silent> <Space>K :<C-u>CocList maps<CR>
nnoremap <silent> <Space>P :<C-u>CocList grep<CR>
xnoremap <silent> <Space>P :<C-u>call <SID>GrepFromSelected(visualmode(), 1)<CR>
nnoremap <silent> <Space><C-p> :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
xnoremap <silent> <Space><C-p> :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <silent> <Space>j :<C-u>CocNext<CR>
nnoremap <silent> <Space>k :<C-u>CocPrev<CR>
nnoremap <silent> <Space>H :<C-u>CocFirst<CR>
nnoremap <silent> <Space>L :<C-u>CocLast<CR>
nnoremap <silent> <Space>' :<C-u>CocCommand fzf-preview.Marks<CR>
nnoremap <silent> <Space>" :<C-u>CocList marks<CR>
nnoremap <silent> <Space>g/ :<C-u>CocList searchhistory<CR>
nnoremap <silent> <Space>t :<C-u>CocList tasks<CR>
nnoremap <silent> <Space><C-f> :<C-u>CocCommand fzf-preview.GitFiles --add-fzf-arg=--preview-window="right:70%"<CR>
nnoremap <silent> <Space>p :<C-u>Rg<CR>
nnoremap <silent> <Space><C-g> :<C-u>call <SID>OpenLazyGit()<CR>
nnoremap <silent> <Space><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> <Space>g; :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> <Space>/ :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--query="'"<CR>
nnoremap <silent> <Space>? :<C-u>CocCommand fzf-preview.BufferLines<CR>
nnoremap <silent> <Space>* :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> <Space>gs :<C-u>let g:fzf_preview_fzf_preview_window_option='right:70%'<Bar>CocCommand fzf-preview.GitStatus<CR>
" show chunk diff at current position
nmap <silent> <Space>gd <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <silent> <Space>gc <Plug>(coc-git-commit)
nnoremap <silent> <Space>gC :<C-u>Clap bcommits<CR>
nnoremap <silent> <Space>ga :<C-u>CocCommand git.chunkStage<CR>
nnoremap <silent> <Space>gu :<C-u>CocCommand git.chunkUndo<CR>
nnoremap <silent> <Space>gz :<C-u>CocCommand git.foldUnchanged<CR>
nnoremap <silent> <Space>gr :<C-u>Git restore --staged %<Bar>CocCommand git.refresh<CR>
" nnoremap <silent> <Space>w :exe 'CocList -I --normal --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <Space>ee :<C-u>CocCommand explorer<CR>
nnoremap <silent> <Space>ev :<C-u>CocCommand explorer --preset vimrc<CR>
nnoremap <silent> <Space>ed :<C-u>CocCommand explorer --preset dotfiles<CR>
nnoremap <silent> <Space>ec :<C-u>execute 'CocCommand explorer' expand('%:p:h')<CR>

" vimwiki
map <Plug>Disable_VimwikiGoto <Plug>VimwikiGoto

" ===
" === Vimspector
" ===
nnoremap <silent> <Space>dd :<C-u>call vimspector#Launch()<CR>
nnoremap <silent> <Space>dq :<C-u>call vimspector#Reset()<CR>
nnoremap <silent> <Space>dc :<C-u>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.code)<CR>
nnoremap <silent> <Space>dv :<C-u>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.variables)<CR>
nnoremap <silent> <Space>dw :<C-u>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.watches)<CR>
nnoremap <silent> <Space>ds :<C-u>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <silent> <Space>do :<C-u>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.output)<CR>

nmap <Space>dl <Plug>VimspectorStepInto
nmap <Space>dj <Plug>VimspectorStepOver
nmap <Space>dk <Plug>VimspectorStepOut
nmap <Space>dh <Plug>VimspectorRunToCursor
nmap <Space>dr <Plug>VimspectorRestart
nmap <Space>de <Plug>VimspectorContinue
nmap <Space>d; <Plug>VimspectorToggleBreakpoint
nmap <Space>di <Plug>VimspectorToggleConditionalBreakpoint

nnoremap <silent> <Space>dx :<C-u>call vimspector#ClearBreakpoints()<CR>

" ===
" === refactor/run tasks
" ===
nnoremap <silent> <Space>ra :<C-u>RnvimrToggle<CR>
" Formatting selected code.
xmap <Space>rf <Plug>(coc-format-selected)
nmap <Space>rf <Plug>(coc-format-selected)
nmap <Space>rF <Plug>(coc-format)
" nmap <Space>rf <Plug>(coc-refactor)
" Apply AutoFix to problem on the current line.
nmap <Space>rx <Plug>(coc-fix-current)
" Apply ALEFix for the whole buffer
" nmap <Space>rX <Plug>(ale_fix)
" Symbol renaming.
nmap <Space>rn <Plug>(coc-rename)
nnoremap <silent> <Space>rr :<C-u>AsyncTask file-run<CR>
nnoremap <silent> <Space>rB :<C-u>AsyncTask file-build<CR>

" ===
" === Whichkey
" ===
nnoremap <silent> <Space> :<C-u>WhichKey '<Space>'<CR>
xnoremap <silent> <Space> :<C-u>WhichKeyVisual '<Space>'<CR>

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
let g:which_space_map.F = 'filer'
let g:which_space_map.f = 'files'
let g:which_space_map.b = 'buffers'
let g:which_space_map.y = 'yank'
let g:which_space_map.Y = 'source'
let g:which_space_map.s = 'vista'
let g:which_space_map.S = 'coc-symbol'
let g:which_space_map.a = 'diagnostic'
let g:which_space_map.l = 'location-list'
let g:which_space_map.q = 'quickfix'
let g:which_space_map.h = 'help'
let g:which_space_map.u = 'undo-tree'
let g:which_space_map.D = 'todo-list'
let g:which_space_map.K = 'key-map'
let g:which_space_map.p = 'grep-preview'
let g:which_space_map.P = 'grep'
let g:which_space_map.j = 'next-item'
let g:which_space_map.k = 'previous-item'
let g:which_space_map.H = 'first-item'
let g:which_space_map.L = 'last-item'
let g:which_space_map.t = 'task'
let g:which_space_map.x = 'open-terminal'
let g:which_space_map['.'] = 'last-list'
let g:which_space_map['/'] = 'line-in-current-buffer'
let g:which_space_map['?'] = 'line-in-all-buffer'
let g:which_space_map["'"] = 'mark-preview'
let g:which_space_map['"'] = 'mark'
let g:which_space_map['*'] = 'grep-current-word'
let g:which_space_map['<C-A>'] = 'diagnostic-preview'
let g:which_space_map['<C-F>'] = 'git-file'
let g:which_space_map['<C-P>'] = 'grep-by-motion'
let g:which_space_map['<C-B>'] = 'buffer-project-mru'
let g:which_space_map['<C-L>'] = 'location-list-preview'
let g:which_space_map['<C-Q>'] = 'quickfix-preview'
let g:which_space_map['<C-G>'] = 'lazygit'
let g:which_space_map['<C-O>'] = 'jump-location'

" For commands
let g:which_space_map.c = {
\   'name': '+command',
\   'c':    'coc-command',
\   'v':    'vim-command',
\   'h':    'command-history'
\ }

" For explorer
let g:which_space_map.e = {
\   'name': '+explorer',
\   'e':    'current-folder',
\   'v':    'vimrc',
\   'd':    'dotfiles'
\ }

" For git/go-to-line
let g:which_space_map.g = {
\   'name': '+git/history',
\   '/':    'search-history',
\   ';':    'change-history',
\   's':    'show-git-status',
\   'd':    'show-chunk-diff',
\   'c':    'show-commit-contains-current-line',
\   'C':    'show-commits-for-current-buffer',
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
\   'q':    'stop',
\   'c':    'browse-code',
\   'v':    'browse-variables',
\   'w':    'browse-watches',
\   's':    'browse-stack-trace',
\   'o':    'browse-output',
\   'l':    'step-into',
\   'j':    'step-over',
\   'k':    'step-out',
\   'h':    'run-to-cursor',
\   'r':    'restart',
\   'e':    'continue',
\   ';':    'toggle-breakpoint',
\   'i':    'toggle-conditional-breakpoint',
\   'x':    'clear-all-breakpoints',
\ }

function! s:GotoWindowAndMaximize(win_id) abort
  call win_gotoid(a:win_id)
  execute 'MaximizerToggle'
endfunction

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

function! s:GrepFromSelected(type, ...)
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
  if a:0 > 0
    execute 'CocList grep '.word
  else
    execute 'CocCommand fzf-preview.ProjectGrep '.word
  endif
endfunction

function! s:OpenLazyGit() abort
  let lazygit_buffer = filter(range(1, bufnr('$')), "getbufvar(v:val, '&buftype') ==# 'terminal' && bufname(v:val) =~# 'lazygit'")
  if empty(lazygit_buffer)
    tabnew
    let g:lazy_git_tab_num = tabpagenr()
    terminal lazygit
    let g:lazy_git_channel = &channel
    normal! a
  else
    execute g:lazy_git_tab_num . 'tabnext'
    normal! a
    call chansend(g:lazy_git_channel, "\<CR>")
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
