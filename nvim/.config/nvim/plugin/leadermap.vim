scriptencoding utf-8

" ===
" === WhichKey
" ===

let g:which_leader_map = {}

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

let g:which_leader_map.n = {
\   'name': '+new',
\   't':    'new-tab',
\   'x':    'new-figlet-symbol',
\ }

let g:which_leader_map.t = {
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
nnoremap <Space>x <Cmd>call OpenTerminal()<CR>

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
nnoremap <Leader>cs <Cmd>CocCommand cSpell.toggleEnableSpellChecker<CR>
nnoremap <Leader>cl <Cmd>call <SID>ToggleCodeLens()<CR>
nnoremap <Leader>cb <Cmd>call <SID>ToggleGitBlame()<CR>
nnoremap <Leader>cp <Cmd>call <SID>ChangeBuildProfile()<CR>
" enter and exit insert mode to update diagnostics
nnoremap <Leader>ca :<C-u>call <SID>ChangeDiagnosticLevel()<CR>i<Esc>
nnoremap <Leader>cg <Cmd>CocCommand git.toggleGutters<CR>
nnoremap <Leader>ci <Cmd>IndentBlanklineToggle<CR>
nnoremap <Leader>cd <Cmd>lcd %:p:h<CR>
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
" === Yank
" ===
nnoremap <Leader>yd <Cmd>call <SID>YankDiagnosticCodes()<CR>
nnoremap <Leader>yp <Cmd>let @+=expand('%:p')<CR>

nnoremap <Leader><C-t> <Cmd>call OpenTerminal('vit')<CR>

" ===
" === Functions
" ===

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

function! OpenTerminal(...) abort
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
