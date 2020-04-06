augroup other_filetypes
    autocmd!
    autocmd FileType python setlocal foldlevel=1
    autocmd FileType python call coc#config('snippets', {'loadFromExtensions': 0,})
    " autocmd FileType python let b:current_syntax = 'python'
    autocmd FileType cpp setlocal foldmethod=syntax
    autocmd FileType fzf
    \   if has('nvim') && !exists('g:fzf_layout')
    \   | set laststatus=0
    \   | execute "autocmd BufLeave <buffer> set laststatus=2"
    \   | endif
augroup END

augroup markdown_filetypes
    autocmd!
    autocmd FileType markdown setlocal iskeyword+=92
    autocmd FileType markdown let b:coc_additional_keywords = ['\']
    " one or two spaces aren't considered as trailing
    autocmd FileType markdown let b:lightline_whitespace_trailing_regexp = '\( \{3,}\|\t\)$'
    autocmd FileType markdown nmap <buffer> [c <Plug>Markdown_MoveToCurHeader
    autocmd FileType markdown inoremap <buffer> ;b ****<Esc>hi
    autocmd FileType markdown inoremap <buffer> ;i **<Esc>i
    autocmd FileType markdown inoremap <buffer> ;m $$<Esc>i
    autocmd FileType markdown inoremap <buffer> ;M $$$$<Esc>hi
    autocmd FileType markdown inoremap <buffer> ;c ```<CR>```<Esc>ka
    autocmd FileType markdown inoremap <buffer> ;d ~~~~<Esc>hi
    autocmd FileType markdown inoremap <buffer> ;; ;
    autocmd FileType markdown inoremap <buffer> ;1 #<Space>
    autocmd FileType markdown inoremap <buffer> ;2 ##<Space>
    autocmd FileType markdown inoremap <buffer> ;3 ###<Space>
    autocmd FileType markdown inoremap <buffer> ;4 ####<Space>
    autocmd FileType markdown let b:switch_custom_definitions = [
    \   {
    \       '\(|:\=-\+\)\+|': {
    \           '|\@<=-\(-\=|\)\@!': ':',
    \           '|\@<=[:-]\=-|\@=': ':-:',
    \           '\(|-\=\)\@<!-|\@=': ':',
    \       },
    \       '\(|:-\+:\)\+|': {
    \           '|\@<=:': '-'
    \       },
    \       '\(|-\+:\)\+|': {
    \           '|\@<=-': ':',
    \           ':|\@=': '-'
    \       }
    \   }
    \ ]
    autocmd FileType markdown inoreabbrev <expr> <buffer> <bar><bar>
    \   <SID>isAtStartOfLine('\|\|') ?
    \   '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
augroup END

augroup common
    autocmd!
    " Close the preview window when completion is done
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent if pumvisible() == 0 && &filetype !=# "cocactions"
    \   | call CocActionAsync('highlight') | endif
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd! User vim-which-key call which_key#register('\', 'g:which_leader_map')
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

" You can add a mapping to `/` in order to open the vista finder for
" searching by adding the following autocommand in your vimrc:
" autocmd FileType vista,vista_kind nnoremap <buffer> <silent> \
         " / :<C-u>call vista#finder#fzf#Run()<CR>
         "
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction
