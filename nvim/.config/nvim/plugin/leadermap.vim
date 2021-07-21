scriptencoding utf-8

" ===
" === WhichKey
" ===

let g:which_leader_map = {}

let g:which_leader_map.V = {
\   'name': '+view',
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
