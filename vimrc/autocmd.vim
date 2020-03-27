augroup filetypes
    autocmd!
    autocmd FileType python setlocal foldmethod=indent foldlevel=1
    autocmd FileType python call coc#config('snippets', {'loadFromExtensions': 0,})
    autocmd FileType markdown setlocal iskeyword+=92
    autocmd FileType markdown let b:coc_additional_keywords = ['\']
    autocmd FileType cpp setlocal foldmethod=syntax
    autocmd FileType fzf
    \   if has('nvim') && !exists('g:fzf_layout')
    \   | set laststatus=0
    \   | execute "autocmd BufLeave <buffer> set laststatus=2"
    \   | endif
augroup END

augroup common
    autocmd!
    " Close the preview window when completion is done
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent if pumvisible() == 0 && &filetype !=# "cocactions" | call CocActionAsync('highlight') | endif
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd! User vim-which-key call which_key#register('\', 'g:which_key_map')
augroup END

" You can add a mapping to `/` in order to open the vista finder for
" searching by adding the following autocommand in your vimrc:
" autocmd FileType vista,vista_kind nnoremap <buffer> <silent> \
         " / :<C-u>call vista#finder#fzf#Run()<CR>
