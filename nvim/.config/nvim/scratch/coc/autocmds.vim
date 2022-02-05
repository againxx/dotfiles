
augroup coc_special
  autocmd!
  " Close the preview window (not completion window, this is why pumvisible() == 0) when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent if pumvisible() == 0 && &filetype !=# 'cocactions'
  \   | call CocActionAsync('highlight') | endif
  autocmd CursorHoldI * silent if coc#float#has_float() == 0 && CocHasProvider('signature') | call CocActionAsync('showSignatureHelp') | endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Automatically close coc-explorer if it is the last window
  autocmd BufEnter *coc-explorer* if winnr('$') == 1 | q | endif
  autocmd CmdwinEnter * let b:coc_suggest_disable = 1
  autocmd BufReadPost * if &readonly | let b:coc_diagnostic_disable = 1 | endif
augroup END

