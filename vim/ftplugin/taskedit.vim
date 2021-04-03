setlocal nolist

if has('nvim')
  nnoremap <buffer><silent> <M-i> :<C-u>call <SID>SearchEditableField(1)<CR>
  nnoremap <buffer><silent> <M-o> :<C-u>call <SID>SearchEditableField(0)<CR>
endif

function! s:SearchEditableField(forward) abort
  for _ in range(v:count1)
    if a:forward
      call search('^\s\+\zs[^:]\+:', 'w')
    else
      call search('^\s\+\zs[^:]\+:', 'bw')
    endif
  endfor
endfunction
