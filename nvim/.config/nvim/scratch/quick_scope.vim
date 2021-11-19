for motion in split('fFtT', '\zs')
  for mapmode in ['nnoremap', 'onoremap', 'xnoremap']
    execute printf(mapmode . ' <expr> <Plug>(QuickScope%s) <SID>SneakReset() . quick_scope#Ready() . quick_scope#Aim("%s") . quick_scope#Reload() . quick_scope#DoubleTap()', motion, motion)
  endfor
endfor

" Fix for https://github.com/unblevable/quick-scope/issues/55
" https://github.com/ayyess/quick-scope/commit/a40654d60dfabd2408e5c8506107e653fa237581
function! s:SneakReset() abort
  if exists('*sneak#reset')
    " The motion doesn't actually matter as it does not run. All that's
    " required is s:st.rst = 1 is set.
    call feedkeys('f', 'ni')
    call sneak#reset('f')
  endif
  return ''
endfunction
