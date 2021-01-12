setlocal foldlevel=1
setlocal colorcolumn=101
call coc#config('snippets.loadFromExtensions', 0)
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
nnoremap <buffer> <silent> <space>rr :CocCommand python.execInTerminal<CR>
xnoremap <buffer> <silent> <space>rs :CocCommand python.execSelectionInTerminal<CR>
