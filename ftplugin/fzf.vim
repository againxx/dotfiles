if has('nvim') && !exists('g:fzf_layout')
    set laststatus=0
    execute "autocmd BufLeave <buffer> set laststatus=2"
endif
autocmd TermClose <buffer> let g:fzf_preview_fzf_preview_window_option='up:60%'
