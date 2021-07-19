scriptencoding utf-8
let g:mapleader = ' '
let g:maplocalleader = '\'

" ===
" === WhichKey
" ===
nnoremap <Leader> :<C-u>WhichKey '<Space>'<CR>
xnoremap <Leader> :<C-u>WhichKeyVisual '<Space>'<CR>

let g:which_leader_map = {}

" For actions
let g:which_leader_map.a = {
\   'name': '+action',
\   'a':    'action-under-cursor',
\   'l':    'action-for-line',
\   'f':    'action-for-file'
\ }

let g:which_leader_map.c = {
\   'name': '+change/command',
\   'l':    'toggle-code-lens',
\   'b':    'toggle-git-blame',
\   'L':    'katex-left-equation',
\   'P':    'toggle-fzf-preview',
\   'S':    'change-statusline-sep',
\   's':    'toggle-check-spelling',
\   'p':    'change-build-profile',
\   'a':    'change-diagnostic-level',
\   'g':    'toggle-git-gutters',
\   'i':    'toggle-indent-line',
\   'w':    'toggle-wiki-autoreload',
\   'd':    'change-directory',
\   'D':    'toggle-coc-diagnostic',
\   'c':    'coc-command',
\   'v':    'vim-command',
\   'h':    'command-history'
\ }

" For vimspector
let g:which_leader_map.d = {
\   'name': '+debug/diagnostic',
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
\   'g':    'diagnostic',
\   'G':    'diagnostic-preview'
\ }

let g:which_leader_map.e = {
\   'name': '+edit/eplorer',
\   'C':    'edit-coc-local-config',
\   's':    'edit-snippets',
\   'm':    'edit-macro&register',
\   't':    'edit-local-task',
\   'T':    'edit-global-task',
\   'r':    'edit-local-task',
\   'R':    'edit-global-task',
\   'v':    'search-vimrc',
\   'd':    'search-dotfiles',
\   'w':    'edit-dictionaries',
\   'e':    'explore-current-git-repo',
\   'c':    'explore-current-folder',
\   'V':    'explore-vimrc',
\   'D':    'explore-dotfiles',
\   'W':    'explore-dictionaries',
\ }

let g:which_leader_map.f = {
\   'name': '+find/file',
\   'f':    'find-files-in-curent-folder',
\   'g':    'find-git-files',
\   'b':    'find-buffers',
\   'h':    'find-help',
\   'o':    'find-old-files',
\   'e':    'file-browser',
\   'm':    'find-man-pages',
\ }

" For git/go-to-line
let g:which_leader_map.g = {
\   'name':  '+git/history',
\   's':     'show-git-status',
\   'd':     'show-chunk-diff',
\   'c':     'show-commit-contains-current-line',
\   'C':     'show-commit-for-current-repo',
\   '<C-C>': 'show-commits-for-current-buffer',
\   'a':     'stage-chunk',
\   'u':     'undo-chunk',
\   'z':     'fold-unchanged',
\   'r':     'restore-current-file',
\   'o':     'object-file',
\ }

" For open/history
let g:which_leader_map.o = {
\   'name':  '+open/old/other',
\   'c':     'command-history',
\   'o':     'jumplist',
\   'm':     'marks',
\   'k':     'keymaps',
\   '/':     'search-history',
\   's':     'snippets',
\   'S':     'coc-sources',
\   'u':     'undo-tree',
\ }

let g:which_leader_map.s = {
\   'name': '+session/source',
\   's':    'session-save',
\   'l':    'session-load',
\   'v':    'source-vimrc',
\ }

let g:which_leader_map.V = {
\   'name': '+view',
\   'm':    'markdown-preview',
\   'c':    'view-error-code',
\   'h':    'view-highlight-group',
\   'H':    'view-highlight-stack',
\   'a':    'view-ascii-value',
\   's':    'view-code-statistic',
\ }

" For visual-multi
let g:which_leader_map.v = {
\   'name':  '+multi-cursor',
\   'v':     'add-cursor-at-pos',
\   'j':     'add-cursor-down',
\   'k':     'add-cursor-up',
\   'h':     'select-left',
\   'l':     'select-right',
\   ';':     'toggle-mappings',
\   'a':     'align-cursor',
\   '<':     'align-char',
\   '>':     'align-regex',
\   'A':     'select-all',
\   's':     'split-region',
\   'gS':    'reselect-last',
\   'c':     'case-setting',
\   'C':     'case-conversion-menu',
\   '/':     'regex-search',
\   'z':     'run-normal-command',
\   'Z':     'run-last-normal-command',
\   'n':     'append-numbers',
\   'N':     'insert-numbers',
\   '<C-V>': 'run-visual-command',
\   'V':     'run-last-visual-command',
\   '@':     'run-macro',
\   '.':     'repeat',
\   '`':     'tools-menu',
\   '"':     'show-registers',
\   '<CR>':  'toggle-single-region',
\   '<C-A>': 'increase-alphabet',
\   '<C-X>': 'decrease-alphabet',
\ }

let g:which_leader_map.n = {
\   'name': '+new',
\   't':    'new-tab',
\   'x':    'new-figlet-symbol',
\ }

let g:which_leader_map.t = {
\   'name':  '+test/task',
\   'n':     'test-nearest',
\   'f':     'test-file',
\   's':     'test-suite/task-start',
\   'l':     'test-last',
\   'o':     'test-open-last-file',
\   't':     'task-choose-tag',
\   'p':     'task-choose-project',
\   'a':     'task-annotate',
\   'C':     'task-calendar',
\   'd':     'task-done',
\   'D':     'task-delete',
\   'e':     'task-edit',
\   'i':     'task-info',
\   'A':     'task-link',
\   'm':     'task-modify',
\   'S':     'task-stats',
\   'g':     'wiki-tag',
\   'G':     'task-tag',
\   'b':     'task-start',
\   'q':     'task-stop',
\   '<C-G>': 'task-grid',
\   'v': {
\     'name': '+view',
\     'd':   'task-burndown-daily',
\     'w':   'task-burndown-weekly',
\     'm':   'task-burndown-monthly',
\     'p':   'task-projects',
\     'P':   'task-projects-summary',
\   },
\   'h': {
\     'name': '+history',
\     'm':   'task-history-monthly',
\     'a':   'task-history-annual',
\     'M':   'task-ghistory-monthly',
\     'A':   'task-ghistory-annual',
\   }
\ }

let g:which_leader_map.q = {
\   'name': '+quit',
\   'q':    'only-quit-buffer',
\   'b':    'quit-buffer',
\   'w':    'wipeout-buffer',
\   't':    'quit-tab',
\   'd':    'quit-debugger',
\   'D':    'close-diagnostic',
\   'c':    'quit-quickfix',
\   'l':    'quit-location-list',
\ }

" For refactor/run
let g:which_leader_map.r = {
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
\   'l':    'list-task',
\ }

let g:which_leader_map.w = {
\   'name': '+wiki',
\   'w':    'default-wiki-index',
\   'T':    'default-wiki-index-in-new-tab',
\   's':    'select-and-open-wiki-index',
\   'r':    'rename-wiki-file',
\   'n':    'notes-wiki-index',
\   'd':    'diary-index',
\   'D':    'delete-wiki-file',
\   'g':    'generate-tag-links',
\   'h':    'convert-to-html',
\   'hh':   'browse-html',
\   'b':    'search-back-links',
\   'B':    'generate-back-links',
\   'f':    'open-wiki-file',
\   'a':    'new-wiki-file',
\   'i':    'insert-note',
\   't': {
\     'name': '+tag',
\     't':    'search-tag-under-current-cursor',
\     's':    'search-tags',
\   },
\   '\': {
\     'name': '+diary',
\     'w':    'today-diary',
\     't':    'today-diary-in-new-tab',
\     'y':    'yesterday-diary',
\     'm':    'tomorrow-diary',
\     'd':    'generate-diary-links',
\     'i':    'generate-diary-links',
\   }
\ }

let g:which_leader_map.y = {
\   'name': '+yank',
\   'y': 'yank-history',
\   'd': 'yank-diagnostic-code',
\   'p': 'yank-file-path',
\ }

" Miscellaneous
let g:which_leader_map = {}
let g:which_leader_map.T = 'translate'
let g:which_leader_map.p = 'grep-string'
let g:which_leader_map['<C-G>'] = 'lazygit'
let g:which_leader_map['<C-T>'] = 'vit'

let g:which_localleader_map = {}

let g:which_localleader_map.t = {
\   'name': '+table',
\   'm':    'table-toggle',
\   'r':    'table-realign',
\   'a':    'tableize',
\   '?':    'cell-representation',
\   'dd':   'delete-row',
\   'dc':   'delete-column'
\ }

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

" Terminal
nnoremap <Space>x <Cmd>call <SID>OpenTerminal()<CR>

" ===
" === Edit files
" ===
nnoremap <Leader>es <Cmd>UltiSnipsEdit!<CR>
nnoremap <Leader>er <Cmd>AsyncTaskEdit<CR>
nnoremap <Leader>eR <Cmd>AsyncTaskEdit!<CR>
nnoremap <Leader>eT <Cmd>CocCommand explorer --preset tmuxp<CR>
nnoremap <Leader>ee <Cmd>CocCommand explorer<CR>
nnoremap <Leader>ev <Cmd>lua require('telescope_config').edit_vimrc()<CR>
nnoremap <Leader>ep <Cmd>lua require('telescope_config').edit_vim_plugins()<CR>
nnoremap <Leader>ed <Cmd>lua require('telescope_config').edit_dotfiles()<CR>
nnoremap <Leader>ew <Cmd>lua require('telescope_config').edit_dictionaries()<CR>
nnoremap <Leader>et <Cmd>lua require('telescope_config').edit_tmuxp()<CR>
nnoremap <Leader>eV <Cmd>CocCommand explorer --preset vimrc<CR>
nnoremap <Leader>eD <Cmd>CocCommand explorer --preset dotfiles<CR>
nnoremap <Leader>eW <Cmd>CocCommand explorer --preset dictionaries<CR>
nnoremap <Leader>ec <Cmd>execute 'CocCommand explorer' expand('%:p:h')<CR>
nnoremap <Leader>eC <Cmd>CocLocalConfig<CR>
nnoremap <Leader>em :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

" ===
" === Session & Source
" ===
nnoremap <Leader>ss <Cmd>CocCommand session.save<CR>
nnoremap <Leader>sl <Cmd>CocCommand session.load<CR>
" Source vimrc file
nnoremap <Leader>sv <Cmd>source $MYVIMRC<Bar>nohlsearch<CR>

" ===
" === View / Visual-multi
" ===
let g:VM_leader = '<Leader>v'
let g:VM_maps = {}
let g:VM_maps['Add Cursor Down'] = '<Leader>vj'
let g:VM_maps['Add Cursor Up'] = '<Leader>vk'
let g:VM_maps['Select l'] = '<Leader>vl'
let g:VM_maps['Select h'] = '<Leader>vh'
let g:VM_maps['Toggle Mappings'] = '<Leader>v;'
let g:VM_maps['Run Visual'] = '<Leader>v<C-v>'
let g:VM_maps['Add Cursor At Pos'] = '<Leader>vv'
let g:VM_maps['Move Right'] = '<M-S-l>'
let g:VM_maps['Move Left'] = '<M-S-h>'

nnoremap <Leader>Vc <Cmd>call <SID>ToggleCocErrorCode()<CR>
nnoremap <Leader>VC <Cmd>call <SID>ToggleCocErrorCode()<CR>
nnoremap <Leader>Vm <Cmd>MarkdownPreview<CR>
nnoremap <Leader>VM <Cmd>MarkdownPreview<CR>
nnoremap <Leader>Vh <Cmd>call SyntaxAttr()<CR>
nnoremap <Leader>VH <Cmd>call <SID>QuerySyntaxStack()<CR>
nnoremap <Leader>Va ga
nnoremap <Leader>VA ga
vnoremap <Leader>Va y:call <SID>EchoFormatsAndChar(@0)<CR>
vnoremap <Leader>VA y:call <SID>EchoFormatsAndChar(@0)<CR>
nnoremap <Leader>Vs <Cmd>terminal tokei<CR>
nnoremap <Leader>VS <Cmd>terminal tokei<CR>

" ===
" === New
" ===
nnoremap <Leader>nt :tabnew %<CR>
nnoremap <Leader>nx :read !figlet<Space>

" ===
" === Change settings / Commands
" ===
nnoremap <Leader>cL <Cmd>call <SID>ToggleEquationFlushedLeft()<CR>
nnoremap <Leader>cP <Cmd>call <SID>ToggleFZFPreview()<CR>
nnoremap <Leader>cS <Cmd>call <SID>ToggleLightlineSep()<CR>
" nnoremap <silent> <Leader>cs :call <SID>ToggleSpellChecking()<CR>
nnoremap <Leader>cs <Cmd>CocCommand cSpell.toggleEnableSpellChecker<CR>
nnoremap <Leader>cl <Cmd>call <SID>ToggleCodeLens()<CR>
nnoremap <Leader>cb <Cmd>call <SID>ToggleGitBlame()<CR>
nnoremap <Leader>cp <Cmd>call <SID>ChangeBuildProfile()<CR>
" enter and exit insert mode to update diagnostics
nnoremap <Leader>ca :<C-u>call <SID>ChangeDiagnosticLevel()<CR>i<Esc>
nnoremap <Leader>cg <Cmd>CocCommand git.toggleGutters<CR>
nnoremap <Leader>ci <Cmd>IndentBlanklineToggle<CR>
nnoremap <Leader>cd <Cmd>cd %:p:h<CR>
nnoremap <Leader>cD <Cmd>call <SID>ToggleCocDiagnostic()<CR>
" Search coc commands
nnoremap <Leader>cc <Cmd>Telescope coc commands<CR>
" Search vim commands
nnoremap <Leader>cv <Cmd>lua require('telescope.builtin').commands()<CR>

" ===
" === Vimwiki
" ===
nnoremap <Leader>ww :<C-u>VimwikiIndex<CR>:cd %:p:h<CR>:CocList files<CR>
nmap <Leader>wT <Plug>VimwikiTabIndex
nnoremap <Leader>wn :<C-u>VimwikiIndex 2<CR>
nmap <Leader>wd <Plug>VimwikiDiaryIndex
nnoremap <Leader>wg :<C-u>VimwikiGenerateTagLinks<CR>
nnoremap <Leader>wtt :<C-u>execute 'VimwikiSearchTags '.expand('<cword>')<Bar>CocList -A --normal locationlist<CR>
nnoremap <Leader>wts :<C-u>VimwikiSearchTags<Space>
nnoremap <Leader>wb :<C-u>VimwikiBacklinks<CR>:lclose<CR>:CocList -A --normal locationlist<CR>
nnoremap <Leader>wB :<C-u>ZettelBackLinks<CR>
nnoremap <Leader>wa :<C-u>ZettelNew<Space>
nnoremap <Leader>wi :<C-u>ZettelInsertNote<CR>

" ===
" === Table-mode
" ===
let g:table_mode_map_prefix = '<LocalLeader>t'
let g:table_mode_tableize_d_map = '<LocalLeader>ta'
nnoremap <LocalLeader>tm <Cmd>TableModeToggle<CR>

" ===
" === Test
" ===
nnoremap <Space>tn <Cmd>call <SID>FindTestRootDir()<bar>TestNearest<CR>
nnoremap <Space>tf <Cmd>call <SID>FindTestRootDir()<bar>TestFile<CR>
nnoremap <Space>ts <Cmd>call <SID>FindTestRootDir()<bar>TestSuite<CR>
nnoremap <Space>tl <Cmd>call <SID>FindTestRootDir()<bar>TestLast<CR>
nnoremap <Space>to <Cmd>call <SID>FindTestRootDir()<bar>TestVisit<CR>

" ===
" === Yank
" ===
nnoremap <Leader>yd <Cmd>call <SID>YankDiagnosticCodes()<CR>
nnoremap <Leader>yp <Cmd>let @+=expand('%:p')<CR>
nnoremap <Leader>yy <Cmd>CocList -A --normal yank<CR>

" ===
" === coc-action
" ===
nmap <Leader>af <Plug>(coc-codeaction)
nmap <Leader>aa <Plug>(coc-codeaction-cursor)
nmap <Leader>al <Plug>(coc-codeaction-line)
" nmap <Leader>a <Plug>(coc-codeaction-selected)
xmap <Leader>a <Plug>(coc-codeaction-selected)

" coc-lists
nnoremap <Leader>ff <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>fg <Cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fh <Cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>fo <Cmd>lua require('telescope_config').oldfiles()<CR>
nnoremap <Leader>fe <Cmd>lua require('telescope_config').file_browser()<CR>
nnoremap <Leader>fm <Cmd>lua require('telescope_config').man_pages()<CR>
nnoremap <Leader>p <Cmd>lua require('telescope.builtin').grep_string()<CR>
xnoremap <Leader>p :<C-u>call <SID>GrepFromSelected()<CR>
" Show locationlist
nnoremap <Leader>ll <Cmd>lua require('telescope.builtin').loclist()<CR>
nnoremap <Leader>lq <Cmd>lua require('telescope.builtin').quickfix()<CR>

nnoremap <Leader>oc <Cmd>lua require('telescope.builtin').command_history()<CR>
nnoremap <Leader>ou <Cmd>UndotreeToggle<CR>
nnoremap <Leader>oo <Cmd>lua require('telescope_config').jumplist()<CR>
nnoremap <Leader>om <Cmd>lua require('telescope.builtin').marks()<CR>
nnoremap <Leader>ok <Cmd>lua require('telescope.builtin').keymaps()<CR>
nnoremap <Leader>os <Cmd>lua require('telescope.builtin').search_history()<CR>
nnoremap <Leader>oS <Cmd>CocList --normal sources<CR>

nnoremap <Leader><C-g> <Cmd>call <SID>OpenTerminal('lazygit')<CR>
nnoremap <Leader><C-t> <Cmd>call <SID>OpenTerminal('vit')<CR>

" ===
" === Git
" ===
nnoremap <Leader>gs <Cmd>lua require('telescope.builtin').git_status()<CR>
" show chunk diff at current position
nmap <silent> <Leader>gd <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <silent> <Leader>gc <Plug>(coc-git-commit)
nnoremap <Leader>gC <Cmd>lua require('telescope.builtin').git_commits()<CR>
nnoremap <Leader>g<C-c> <Cmd>lua require('telescope_config').git_bcommits()<CR>
nnoremap <Leader>gb <Cmd>lua require('telescope.builtin').git_branches()<CR>
nnoremap <Leader>ga <Cmd>CocCommand git.chunkStage<CR>
nnoremap <Leader>gu <Cmd>CocCommand git.chunkUndo<CR>
nnoremap <Leader>gz <Cmd>CocCommand git.foldUnchanged<CR>
nnoremap <Leader>gr <Cmd>Git restore --staged %<Bar>CocCommand git.refresh<CR>
" nnoremap <Leader>go <Cmd>Clap git_object_files<CR>

" ===
" === Quit
" ===
nnoremap <Leader>qq <Cmd>call <SID>CloseBufferOrQuickfixOrLocalistWindow()<CR>
nnoremap <Leader>qb <Cmd>silent! bdelete!<CR>
nnoremap <Leader>qw <Cmd>silent! bwipeout!<CR>
nnoremap <Leader>qt <Cmd>tabclose<CR>
nnoremap <Leader>qd <Cmd>VimspectorReset<CR>
nnoremap <Leader>qD <Cmd>let b:coc_diagnostic_disable = 1<Bar>edit<CR>
nnoremap <Leader>qc <Cmd>cclose<CR>
nnoremap <Leader>ql <Cmd>lclose<CR>

" ===
" ===  coc-translator
" ===
" popup
nmap <Leader>T <Plug>(coc-translator-p)
vmap <Leader>T <Plug>(coc-translator-pv)

" ===
" === refactor/run tasks
" ===
nnoremap <Leader>ra <Cmd>RnvimrToggle<CR>
" Formatting selected code.
xmap <Leader>rf <Plug>(coc-format-selected)
nmap <Leader>rf <Plug>(coc-format-selected)
nmap <Leader>rF <Plug>(coc-format)
" nmap <Leader>rf <Plug>(coc-refactor)
" Apply AutoFix to problem on the current line.
nmap <Leader>rx <Plug>(coc-fix-current)
" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
nnoremap <Leader>rr <Cmd>cclose<Bar>AsyncTask file-run<CR>
nnoremap <Leader>rb <Cmd>AsyncTask project-build<CR>
nnoremap <Leader>rB <Cmd>AsyncTask file-build<CR>
nnoremap <Leader>rl <Cmd>lua require('telescope_config').asynctasks()<CR> 

" ===
" === Vimspector
" ===
nnoremap <Leader>dd <Cmd>call vimspector#Launch()<CR>
nnoremap <Leader>dq <Cmd>call vimspector#Reset()<CR>
nnoremap <Leader>dc <Cmd>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.code)<CR>
nnoremap <Leader>dv <Cmd>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.variables)<CR>
nnoremap <Leader>dw <Cmd>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.watches)<CR>
nnoremap <Leader>ds <Cmd>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <Leader>do <Cmd>call <SID>GotoWindowAndMaximize(g:vimspector_session_windows.output)<CR>
nnoremap <Leader>dx <Cmd>call vimspector#ClearBreakpoints()<CR>

nmap <Space>dl <Plug>VimspectorStepInto
nmap <Space>dj <Plug>VimspectorStepOver
nmap <Space>dk <Plug>VimspectorStepOut
nmap <Space>dh <Plug>VimspectorRunToCursor
nmap <Space>dr <Plug>VimspectorRestart
nmap <Space>de <Plug>VimspectorContinue
nmap <Space>d; <Plug>VimspectorToggleBreakpoint
nmap <Space>di <Plug>VimspectorToggleConditionalBreakpoint
" Show all diagnostics.
nnoremap <Leader>dg <Cmd>Telescope coc diagnostics<CR>
nnoremap <Leader>dG <Cmd>Telescope coc workspace_diagnostics<CR>

" Search workspace symbols.
" nnoremap <silent> <Leader>s <Cmd>Vista finder<CR>
nnoremap <Leader>ss <Cmd>lua require('telescope_config').document_symbols()<CR>
nnoremap <Leader>sa <Cmd>lua require('telescope_config').workspace_symbols()<CR>

" ===
" === Functions
" ===

function! s:AutoVerticalSplit(fname)
  if winlayout()[0] ==# 'leaf'
    exec 'vsplit '.a:fname
  else
    exec 'edit '.a:fname
  endif
endfunction

" Coc
function! s:ToggleCocErrorCode() abort
  if coc#util#get_config('diagnostic')['format'] ==# "%message\n[%source]"
    call coc#config('diagnostic.format', "%message\n[%source:%code]")
  else
    call coc#config('diagnostic.format', "%message\n[%source]")
  endif
endfunction

function! s:ChangeDiagnosticLevel() abort
  if coc#util#get_config('diagnostic')['level'] ==# 'warning'
    call coc#config('diagnostic.level', 'hint')
  else
    call coc#config('diagnostic.level', 'warning')
  endif
endfunction

" Markdown-Preview
function! s:ToggleEquationFlushedLeft() abort
  if exists("g:mkdp_preview_options['katex']['fleqn']")
    if g:mkdp_preview_options['katex']['fleqn'] == 1
      let g:mkdp_preview_options['katex']['fleqn'] = 0
    else
      let g:mkdp_preview_options['katex']['fleqn'] = 1
    endif
  else
    let g:mkdp_preview_options['katex'] = {'fleqn': 1}
  endif
endfunction

" FZF-Preview
function! s:ToggleFZFPreview() abort
  if exists('g:vista_fzf_preview')
    unlet g:vista_fzf_preview
    unlet g:fzf_layout
  else
    let g:vista_fzf_preview = ['up:60%']
    let g:fzf_layout = {
    \   'window': {
    \   'width': 0.9,
    \   'height': 0.9,
    \   'xoffset': 0.5,
    \   'border': 'sharp'
    \   }
    \ }
  endif
endfunction

" Lightline Separate
function! s:ToggleLightlineSep() abort
  if g:lightline.separator.left == ''
    let g:lightline.separator = {
    \   'left': '',
    \   'right': ''
    \ }
    let g:lightline.subseparator = {
    \   'left': '',
    \   'right': ''
    \ }
  elseif g:lightline.separator.left == ''
    let g:lightline.separator = {
    \   'left': ' ',
    \   'right': ' '
    \ }
    let g:lightline.subseparator = {
    \   'left': '¦',
    \   'right': '¦'
    \ }
  else
    let g:lightline.separator = {
    \   'left': '',
    \   'right': ''
    \ }
    let g:lightline.subseparator = {
    \   'left': '',
    \   'right': ''
    \ }
  endif
  call lightline#toggle()
  call lightline#toggle()
endfunction

function! s:ToggleSpellChecking() abort
  if &l:spell ==# 0
    setlocal spell spelllang=en_us
  else
    setlocal nospell
  endif
endfunction

function! s:ToggleCodeLens() abort
  if coc#util#get_config('codeLens')['enable']
    call coc#config('codeLens.enable', 0)
  else
    call coc#config('codeLens.enable', 1)
  endif
  if &filetype ==# 'rust'
    execute 'CocCommand rust-analyzer.toggleInlayHints'
  endif
endfunction

function! s:ToggleGitBlame() abort
  if coc#util#get_config('git')['addGBlameToVirtualText']
    call coc#config('git.addGBlameToVirtualText', 0)
  else
    call coc#config('git.addGBlameToVirtualText', 1)
  endif
endfunction

function! s:ChangeBuildProfile() abort
  if g:asynctasks_profile ==# 'debug'
    execute 'AsyncTaskProfile release'
  elseif g:asynctasks_profile ==# 'release'
    execute 'AsyncTaskProfile release-debug'
  elseif g:asynctasks_profile ==# 'release-debug'
    execute 'AsyncTaskProfile debug'
  else
    echo 'Unknown current profile!'
  endif
endfunction

function! s:ToggleCocDiagnostic() abort
  if  get(b:, 'coc_diagnostic_disable', 0)
    let b:coc_diagnostic_disable = 0
  else
    let b:coc_diagnostic_disable = 1
  endif
  edit
endfunction

" echo different formats and the corresponding char for a given number
function! s:EchoFormatsAndChar(num) abort
  let l:input_num = a:num
  let l:hex_reg = '\v^(\\x|0x|\\u|u\+)'
  if l:input_num =~? '\v^\d+$' " decimal
    let l:output_num = '0x' . printf('%x', l:input_num)
  else " hexdecimal
    if l:input_num =~? l:hex_reg
      let l:input_num = '0x' . substitute(l:input_num, l:hex_reg, '', 'g')
    else
      let l:input_num = '0x' . l:input_num
    endif
    let l:output_num = printf('%d', l:input_num)
  endif
  let @" = nr2char(l:output_num)
  echo '<' . l:input_num . '> ' . l:output_num . ' ' . @"
endfunction

function s:YankDiagnosticCodes() abort
  let codes = join(s:GetDiagnosticCodes())
  let @@ = codes
  let @+ = codes
endfunction

function! s:GetDiagnosticCodes() abort
  let coc_diagnostics = CocAction('diagnosticList')
  let current_line = line('.')
  let current_file_path = expand('%:p')
  let codes = []
  for diagnostic in coc_diagnostics
    if diagnostic.file ==# current_file_path && current_line == diagnostic.lnum
    \   && diagnostic.location.range.start.character < col('.')
    \   && col('.') <= diagnostic.location.range.end.character
      call add(codes, diagnostic.code)
    endif
  endfor
  return codes
endfunction

function! s:QuerySyntaxStack() abort
  for id in synstack(line('.'), col('.'))
    echo synIDattr(id, 'name')
  endfor
endfunction

function s:CloseBufferOrQuickfixOrLocalistWindow() abort
  if !empty(filter(getwininfo(), 'v:val.quickfix'))
    cclose
    lclose
  else
    silent! Bdelete!
    redrawtabline
  endif
endfunction

function! s:GrepFromSelected() abort
  let saved_unnamed_register = @@
  normal! `<v`>y
  let word = substitute(@@, '\n$', '', 'g')
  let @@ = saved_unnamed_register
  call luaeval("require('telescope.builtin').grep_string({search = _A})", word)
endfunction

function! s:OpenTerminal(...) abort
  let command_name = a:0 > 0 ? a:1 : $SHELL
  let shell_buffer = filter(range(1, bufnr('$')),
  \   "getbufvar(v:val, '&buftype') ==# 'terminal' && bufname(v:val) =~# '" . command_name . "'")
  if empty(shell_buffer)
    tabnew
    let g:shell_tab_num = tabpagenr()
    if a:0 > 0
      execute 'terminal' command_name
    else
      terminal
    endif
    let g:shell_channel_id = &channel
    set nobuflisted
    startinsert
  else
    execute g:shell_tab_num . 'tabnext'
    if command_name ==# 'lazygit'
      call chansend(g:shell_channel_id, "\<CR>")
    endif
    if command_name !=# $SHELL
      startinsert
    endif
  endif
endfunction

function! s:GotoWindowAndMaximize(win_id) abort
  call win_gotoid(a:win_id)
  execute 'MaximizerToggle!'
endfunction

function! s:FindTestRootDir() abort
  if exists('g:test_project_root_pattern')
    for pattern in g:test_project_root_pattern
      let l:root_dir = finddir(pattern, '.;' . $HOME)
      if !empty(l:root_dir)
        let g:test#project_root = fnamemodify(l:root_dir, ':h')
        return
      endif
    endfor
  endif
endfunction
