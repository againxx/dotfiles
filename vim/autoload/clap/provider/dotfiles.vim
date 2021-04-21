let s:save_cpo = &cpoptions
set cpoptions&vim

let s:default_dotfiles_dir = '~/dotfiles/'
let s:dotfiles = {}

function! s:list_dotfiles() abort
  let l:dotfiles = systemlist('rg --hidden --ignore-file ~/dotfiles/.rgignore --files ~/dotfiles/')
  call map(l:dotfiles, 's:modify_file_name(v:val)')
  return l:dotfiles
endfunction

function! s:modify_file_name(file_name) abort
  let modified_file_name = fnamemodify(a:file_name, ':~:s?' . escape(s:default_dotfiles_dir, '~') . '??')
  if g:clap_enable_icon && clap#maple#is_available()
    return clap#icon#get(modified_file_name) . ' ' . modified_file_name
  else
    return modified_file_name
  endif
endfunction

function! s:into_filename(line) abort
  if g:clap_enable_icon && clap#maple#is_available()
    return s:default_dotfiles_dir . a:line[4:]
  else
    return s:default_dotfiles_dir . a:line
  endif
endfunction

function! s:dotfiles_sink_impl(selected) abort
  let fpath = s:into_filename(a:selected)
  call clap#sink#edit_with_open_action(fpath)
endfunction

function! s:dotfiles_sink_star_impl(lines) abort
  call clap#util#open_quickfix(map(map(a:lines, 's:into_filename(v:val)'),
        \ '{'.
        \   '"filename": v:val,'.
        \   '"text": strftime("Modified %b,%d %Y %H:%M:%S", getftime(v:val))." ".getfperm(v:val)'.
        \ '}'))
endfunction

function! s:dotfiles_on_move_impl() abort
  call clap#preview#file(s:into_filename(g:clap.display.getcurline()))
endfunction

let s:dotfiles.source = function('s:list_dotfiles')
let s:dotfiles.sink = function('s:dotfiles_sink_impl')
let s:dotfiles['sink*'] = function('s:dotfiles_sink_star_impl')
let s:dotfiles.on_move = function('s:dotfiles_on_move_impl')
let s:dotfiles.on_move_async = function('clap#impl#on_move#async')
let s:dotfiles.syntax = 'clap_files'
let s:dotfiles.support_open_action = v:true

let g:clap#provider#dotfiles# = s:dotfiles

let &cpoptions = s:save_cpo
unlet s:save_cpo
