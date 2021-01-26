augroup cmake_special
    autocmd!
    autocmd BufEnter * if exists("b:ros_package_path") && &filetype ==# 'cmake' | call <SID>catkinInit() | endif
augroup END

function! s:catkinInit() abort
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction
