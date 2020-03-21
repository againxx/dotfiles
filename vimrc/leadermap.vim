" Mardown-Preview
nmap <leader>mp <Plug>MarkdownPreview

" Sudo save
nnoremap <leader>sw :w !sudo tee %<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>rf <Plug>(coc-refactor)
" Reload vimrc file
nnoremap <leader>rl :source ~/.vimrc<CR>
nnoremap <leader>qq :silent! bdelete!<CR>

" Coc
" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)
" xmap <leader>a  <Plug>(coc-codeaction-selected)

" coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
