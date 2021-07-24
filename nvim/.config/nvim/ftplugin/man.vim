nnoremap <buffer><silent> [[ :<C-u> call <SID>FindLessIndentionLine(v:false)<CR>
nnoremap <buffer><silent> [[ :<C-u> call <SID>FindLessIndentionLine(v:true)<CR>
nmap <buffer> <Space>/ <Plug>(incsearch-forward)^\s\+\zs

function! s:FindLessIndentionLine(backward) abort
  let num_space = matchstrpos(getline('.'), '^\s\+')[-1]
  let num_space = max([0, num_space - 1])
  if a:backward
    call search('^\s\{,'.num_space.'}\w', 'wbe')
  else
    call search('^\s\{,'.num_space.'}\w', 'we')
  endif
endfunction
