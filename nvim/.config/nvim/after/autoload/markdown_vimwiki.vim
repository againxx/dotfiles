function markdown_vimwiki#SetCommonConfigs() abort
  setlocal iskeyword+=92 conceallevel=2
  let b:coc_additional_keywords = ['\']
  if exists('b:match_words')
    let b:match_words .= ',\\begin{\w\+}:\\end{\w\+}'
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
  \       '!\@<!\[\([^]]\+\)\](\([^)]\+\))': '\[\[\2|\1\]\]',
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
  \       '{{\([^|]\+\)|\([^|]*\)|style="width:\(\d\+\)px"}}': '!\[\2\](\1 =\3x)',
  \       '!\[\([^]]*\)\](\([^)]\+\) =\(\d\+\)x)': '{{\2|\1|style="width:\3px"}}',
  \   },
  \   ['\\rightarrow', '\\longrightarrow', '\\Rightarrow', '\\Longrightarrow'],
  \   ['\\leftarrow', '\\longleftarrow', '\\Leftarrow', '\\Longleftarrow'],
  \   ['\\leftrightarrow', '\\longleftrightarrow', '\\Leftrightarrow', '\\Longleftrightarrow', '\\iff'],
  \   ['\\hat', '\\tilde', '\\widehat', '\\widetilde', '\\overline', '\\bar'],
  \   ['\\ldots', '\\cdots'],
  \   ['- [ ]', '- [X]']
  \ ]

  inoremap <buffer> ;w <Esc>/<++><CR>:nohlsearch<CR>"_c4l
  inoremap <buffer> ;e <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l
  inoremap <buffer> ;o <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l<CR>
  inoremap <buffer> ;m $$<++><C-o>F$
  inoremap <buffer> ;h $$<Space><Space>$$<C-o>2h
  inoremap <buffer> ;c ``<Space><++><C-o>F`
  inoremap <buffer> ;t -<Space>[<Space>]<Space>
  inoremap <buffer> ;T *<Space>[<Space>]<Space>
  inoremap <buffer> ;n <Esc>A<Space>\\<CR>
  inoremap <buffer> ;q <Esc>/[)}\]]<CR>:nohlsearch<CR>a
  inoremap <buffer> ;; ;
  nnoremap <buffer> <Space><Space> /<++><CR>:nohlsearch<CR>"_c4l

  " when vim-plug first load TableMode the cursor will be put in the first line,
  " use `. to jump to the original place
  inoreabbrev <expr> <buffer> <bar><bar>
  \   <SID>IsAtStartOfLine('\|\|') ?
  \   '<c-o>:TableModeEnable<cr><c-o>`.<bar><space><bar><left><left>' : '<bar><bar>'

  if g:colors_name ==# 'ayu'
    hi! link Conceal Function
    hi! link TaskwikiTaskPriority CocErrorSign
  endif
endfunction

function! s:IsAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

