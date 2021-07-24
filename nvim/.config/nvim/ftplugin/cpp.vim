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

nnoremap <buffer> [h
\   {:execute "keepjumps normal! ?^\\(#include\\<bar>#define\\)\r"<CR>:nohlsearch<CR>
nnoremap <buffer> ]h
\   }:execute "keepjumps normal! /^#include\r"<CR>:nohlsearch<CR>:keepjumps normal }k<CR>

function! s:CatkinInit() abort
  setlocal colorcolumn=121
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  let b:ultisnips_cpp_style = 'ros'
endfunction

call catkin#DetectPackage(function('s:CatkinInit'))

if !exists('b:ros_package_path')
  command! -buffer -nargs=0 A execute 'CocCommand clangd.switchSourceHeader'
endif
