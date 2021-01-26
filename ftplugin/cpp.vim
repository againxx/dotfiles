setlocal foldmethod=syntax
set commentstring=//\ %s
let b:switch_custom_definitions = [
\   {
\       '\(std::cout.*\)"\s*<<\s*''\\n'';': '\1\\n";',
\       '\(std::cout.*\)\\n";': '\1" << std::endl;',
\       '\(std::cout.*\)std::endl;': '\1''\\n'';',
\       '\<\(double\|int\|float\)\((.\+)\)': 'static_cast<\1>\2',
\       '^\(.\{-}\)/\*\(.\{-}\)\s*\*/': '\1//\2',
\       '^\(.\{-}\)//\(.\{-}\)\s*$': '\1/*\2 */',
\       '^#include\s*"\([^"]*\)"\s*': '#include <\1>',
\       '^#include\s*<\(.*\)>\s*': '#include "\1"'
\   }
\ ]
call coc#config('diagnostic.format', "%message\n[%source:%code]")

augroup cpp_special
    autocmd!
    autocmd BufEnter * if exists("b:ros_package_path") && &filetype ==# 'cpp' | call <SID>catkinInit() | endif
augroup END

nnoremap <buffer> [h
\   {:execute "keepjumps normal! ?^#include\r"<CR>:nohlsearch<CR>
nnoremap <buffer> ]h
\   }:execute "keepjumps normal! /^#include\r"<CR>:nohlsearch<CR>:keepjumps normal }k<CR>
nnoremap <buffer> <space>rp :AsyncTask project-run<CR>
nnoremap <buffer> <space>rb :AsyncTask project-build<CR>
nnoremap <buffer> <space>ri :AsyncTask project-init<CR>
nnoremap <buffer> <space>rc :AsyncTask project-clean<CR>
" nnoremap <buffer> <space>rF :ALEFix clang-format<CR>
" nnoremap <buffer> <space>rX :ALEFix clangtidy<CR>
nmap <buffer> gq <Plug>(coc-format-selected)
nmap <buffer> gqq gqj
xmap <buffer> gq <Plug>(coc-format-selected)

function! s:catkinInit() abort
    setlocal colorcolumn=121
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
    let g:asynctasks_environ = {'package_name': string(b:ros_package_name)[1:-2]}
    let b:ultisnips_cpp_style = 'ros'
    call coc#config('diagnostic-languageserver.linters', {
    \   'cpplint': {
    \       'args': [
    \           '--linelength=120',
    \           '--filter=-whitespace/braces,-build/include_subdir,-whitespace/newline',
    \           '%file'
    \       ]
    \   }
    \ })
endfunction
