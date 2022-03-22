if has('nvim') && !exists('g:fzf_layout')
  set laststatus=0
  execute 'autocmd BufLeave <buffer> set laststatus=3'
endif

autocmd TermClose <buffer> let g:fzf_preview_fzf_preview_window_option='up:60%'
tnoremap <silent><C-a> <C-\><C-n>:autocmd! TermClose <buffer><CR>a<C-a>
tnoremap <silent><C-r> <C-\><C-n>:autocmd! TermClose <buffer><CR>a<C-r>
tnoremap <silent><C-c> <C-\><C-n>:autocmd! TermClose <buffer><CR>a<C-c>
tnoremap <silent>> <C-\><C-n>:autocmd! TermClose <buffer><CR>a>
