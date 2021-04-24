scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

let s:git_object_files = {}
let s:prefix_trees = []
let s:git_dir = ''

function! s:object_files_sink_impl(selected) abort
  execute 'Gedit' join(s:prefix_trees, '') . a:selected
endfunction

function! s:list_refs() abort
  " 'showbreak' option will break the strdisplaywidth() output
  let s:break_string = &showbreak
  let &showbreak = ''

  let current_git_dir = FugitiveGitDir()
  if current_git_dir !=# s:git_dir || len(s:prefix_trees) == 0
    let s:git_dir = current_git_dir
    let s:prefix_trees = []
    call clap#spinner#set_raw(' refs:')
    let s:candidates = fugitive#EditComplete('>', '', 0)
    call map(s:candidates, 'v:val[1:]')
  else
    call clap#spinner#set_raw(' ' . join(s:prefix_trees, ''))
  endif
  return s:candidates
endfunction

function! s:update_tree_objects(tree_object) abort
  if len(a:tree_object) != 0
    if len(s:prefix_trees) == 0
      call add(s:prefix_trees, a:tree_object . ':')
    else
      call add(s:prefix_trees, a:tree_object)
    endif
  else
    silent! call remove(s:prefix_trees, -1)
  endif

  if len(s:prefix_trees) == 0
    call s:list_refs()
    let complete_items = s:candidates
  else
    let complete_items = fugitive#CompleteObject(join(s:prefix_trees, ''))
    if len(complete_items) == 1
      let file_name = remove(s:prefix_trees, -1)
      return complete_items
    else
      let s:candidates = complete_items
      call clap#spinner#set_raw(' ' . join(s:prefix_trees, ''))
    endif
  endif
  call map(s:candidates, 'substitute(v:val, "^' . join(s:prefix_trees, '') . '", "", "")')
  call s:update_input_and_display()
  return complete_items
endfunction

function! s:update_input_and_display() abort
  call g:clap.input.set('')
  call g:clap.display.set_lines(s:candidates)
  call g:clap#display_win.shrink_if_undersize()
endfunction

function! s:object_files_on_typed() abort
  call clap#highlight#clear()
  let cur_input = g:clap.input.get()
  let has_upper_letter = cur_input =~# '.*\u.*'
  let matched_index = has_upper_letter ? index(s:candidates, cur_input) : index(s:candidates, cur_input, 0, v:true)
  if matched_index != -1
    let matched_name = s:candidates[matched_index]
    call s:update_tree_objects(matched_name)
  else
    call s:do_filter()
  endif
endfunction

function! s:bs_action() abort
  call clap#highlight#clear()

  let input = g:clap.input.get()
  if input ==# ''
    call s:update_tree_objects('')
  else
    call g:clap.input.set(input[:-2])
  endif
endfunction

function! s:back_action() abort
  call s:update_tree_objects('')
endfunction

function! s:tab_action() abort
  call s:update_tree_objects(g:clap.display.getcurline())
endfunction

function! s:do_filter() abort
  let query = g:clap.input.get()
  if query ==# ''
    call g:clap.display.set_lines(s:candidates)
    call g:clap#display_win.shrink_if_undersize()
  else
    call clap#filter#on_typed(function('clap#filter#sync'), query, s:candidates)
  endif
endfunction

function! s:object_files_on_exit() abort
  let &showbreak = s:break_string
endfunction

" function! s:object_files_on_move_impl() abort
  " call clap#preview#file(s:into_filename(g:clap.display.getcurline()))
" endfunction

let s:git_object_files.source = function('s:list_refs')
let s:git_object_files.sink = function('s:object_files_sink_impl')
let s:git_object_files.on_exit = function('s:object_files_on_exit')
let s:git_object_files.on_typed = function('s:object_files_on_typed')
" let s:git_object_files.on_move = function('s:object_files_on_move_impl')
" let s:git_object_files.on_move_async = function('clap#impl#on_move#async')
let s:git_object_files.syntax = 'clap_files'
let s:git_object_files.support_open_action = v:true
let s:git_object_files.bs_action = function('s:bs_action')
let s:git_object_files.back_action = function('s:back_action')
let s:git_object_files.tab_action = function('s:tab_action')

let g:clap#provider#git_object_files# = s:git_object_files
let &cpoptions = s:save_cpo
unlet s:save_cpo
