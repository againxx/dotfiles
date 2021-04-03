if has('nvim')
  nnoremap <buffer><silent> <M-i> :<C-u>call search('<Bar>.\{-}<Bar>', 'w')<CR>
  nnoremap <buffer><silent> <M-o> :<C-u>call search('<Bar>.\{-}<Bar>', 'wb')<CR>
endif
nnoremap <buffer><silent> ]t :<C-u>call search('<Bar>.\{-}<Bar>', 'w')<CR>
nnoremap <buffer><silent> [t :<C-u>call search('<Bar>.\{-}<Bar>', 'wb')<CR>
