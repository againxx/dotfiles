setlocal foldlevel=1
setlocal colorcolumn=101
call coc#config('snippets.loadFromExtensions', 0)
call coc#config('diagnostic-languageserver.linters', {
\   'mypy': {
\       'args': [
\           '--no-color-output',
\           '--no-error-summary',
\           '--show-column-numbers',
\           '--follow-imports=silent',
\           '--cache-dir='.$HOME.'/.cache/mypy',
\           '%file'
\       ]
\   }
\ })
" dynamically set python.condaPath
if !empty($CONDA_PREFIX)
  call coc#config('python.condaPath', $CONDA_PREFIX.'/bin/python')
endif
let b:switch_custom_definitions = [
\   {
\       'print\s\+\(.*\)': 'print(\1)',
\       'print(\([^)]*\))': 'print \1',
\       'is\s\(not\)\@!': 'is not ',
\       'is\snot': 'is',
\   }
\ ]

map <buffer> [f [m
map <buffer> ]f ]m
map <buffer> [F [M
map <buffer> ]F ]M
nnoremap <buffer> <Space><Space> 0/TODO<CR>:nohlsearch<CR>"_c4l
nnoremap <buffer> [h
\   {:execute "keepjumps normal! ?^\\(import\\<bar>from\\)\r"<CR>:nohlsearch<CR>
nnoremap <buffer> ]h
\   }:execute "keepjumps normal! /^\\(import\\<bar>from\\)\r"<CR>:nohlsearch<CR>:keepjumps normal }k<CR>

if g:colors_name ==# 'ayu'
  hi pythonSelf          gui=italic guifg=#A37ACC guibg=NONE
  hi pythonParam         guifg=#F07178 guibg=NONE
  hi pythonInclude       gui=bold,italic guifg=#FFC44C
  " hi pythonMethod     guifg=#ffaf87 guibg=NONE
  hi! link pythonDocstring pythonComment
endif
