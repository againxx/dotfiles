scriptencoding utf-8

" ===
" === WhichKey
" ===

let g:which_leader_map = {}

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

" ===
" === Table-mode
" ===
let g:table_mode_map_prefix = '<LocalLeader>t'
let g:table_mode_tableize_d_map = '<LocalLeader>ta'
nnoremap <LocalLeader>tm <Cmd>TableModeToggle<CR>
