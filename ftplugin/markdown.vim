setlocal iskeyword+=92 conceallevel=2
let b:coc_pairs_disabled = ['<']
let b:coc_additional_keywords = ['\']
let g:vim_markdown_folding_disabled = 0
let g:sneak#label = 0 | call sneak#init()
" one or two spaces aren't considered as trailing
let b:lightline_whitespace_trailing_regexp = '\( \{3,}\|\t\)$'
if exists('b:match_words')
  let b:match_words.=',\\begin{\w\+}:\\end{\w\+}'
endif

let b:switch_custom_definitions = [
\   {
\       '\(|:\=-\+\)\+|': {
\           '|\@<=-\(-\=|\)\@!': ':',
\           '|\@<=[:-]\=-|\@=': ':-:',
\           '\(|-\=\)\@<!-|\@=': ':',
\       },
\       '\(|:-\+:\)\+|': {
\           '|\@<=:': '-'
\       },
\       '\(|-\+:\)\+|': {
\           '|\@<=-': ':',
\           ':|\@=': '-'
\       },
\       '^\(\%([^|]\+|\)\+[^|]\+\)': '|\1|',
\       '\[\([^]]\+\)\](\([^)]\+\))': '\[\[\2|\1\]\]',
\       '\[\[\([^]|]\+\)|\([^]]\+\)\]\]': '\[\2\](\1)',
\       '\[\[\([^]|]\+\)\]\]': '\[\1\](\1)',
\       '^# \(.*\)$': '= \1 =',
\       '^## \(.*\)$': '== \1 ==',
\       '^### \(.*\)$': '=== \1 ===',
\       '^#### \(.*\)$': '==== \1 ====',
\       '^##### \(.*\)$': '===== \1 =====',
\       '^###### \(.*\)$': '====== \1 ======',
\       '^= \(.*\) =$': '# \1',
\       '^== \(.*\) ==$': '## \1',
\       '^=== \(.*\) ===$': '### \1',
\       '^==== \(.*\) ====$': '#### \1',
\       '^===== \(.*\) =====$': '##### \1',
\       '^====== \(.*\) ======$': '###### \1',
\   },
\   ['\\rightarrow', '\\longrightarrow', '\\Rightarrow', '\\Longrightarrow'],
\   ['\\leftarrow', '\\longleftarrow', '\\Leftarrow', '\\Longleftarrow'],
\   ['\\leftrightarrow', '\\longleftrightarrow', '\\Leftrightarrow', '\\Longleftrightarrow', '\\iff'],
\   ['\\hat', '\\tilde', '\\widehat', '\\widetilde', '\\overline', '\\bar'],
\   ['\\ldots', '\\cdots'],
\   ['- [ ]', '- [X]']
\ ]

nmap <buffer> [h <Plug>Markdown_MoveToCurHeader
inoremap <buffer> ;b ****<Space><++><Esc>F*hi
inoremap <buffer> ;s ~~~~<Space><++><Esc>F~hi
inoremap <buffer> ;i **<Space><++><Esc>F*i
inoremap <buffer> ;C ```<CR>```<Esc>ka
inoremap <buffer> ;p ![](<++>)<Space><++><Esc>F[a
inoremap <buffer> ;a [](<++>)<Space><++><Esc>F[a
inoremap <buffer> ;r ##<Space>Reference<Esc>
inoremap <buffer> ;M $$<CR>$$<Esc>O
inoremap <buffer> ;1 #<Space>
inoremap <buffer> ;2 ##<Space>
inoremap <buffer> ;3 ###<Space>
inoremap <buffer> ;4 ####<Space>
inoremap <buffer> ;w <Esc>/<++><CR>:nohlsearch<CR>"_c4l
inoremap <buffer> ;e <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l
inoremap <buffer> ;o <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l<CR>
inoremap <buffer> ;m $$<++><Esc>F$i
inoremap <buffer> ;h $$<Space><Space>$$<Esc>2hi
inoremap <buffer> ;c ``<Space><++><Esc>F`i
inoremap <buffer> ;d -<Space>[<Space>]<Space>
inoremap <buffer> ;n <Esc>A<Space>\\<CR>
inoremap <buffer> ;; ;
inoremap <buffer> ;q <Esc>/[)}\]]<CR>:nohlsearch<CR>a
nnoremap <buffer> <Space><Space> /<++><CR>:nohlsearch<CR>"_c4l
" when vim-plug first load TableMode the cursor will be put in the first line,
" use `. to jump to the original place
inoreabbrev <expr> <buffer> <bar><bar>
\   <SID>isAtStartOfLine('\|\|') ?
\   '<c-o>:TableModeEnable<cr><c-o>`.<bar><space><bar><left><left>' : '<bar><bar>'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction
