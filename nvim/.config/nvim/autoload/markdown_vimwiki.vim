let markdown_vimwiki#custom_switches = [
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

" when packer first load TableMode the TableModeEnable command does not have
" effect
inoreabbrev <expr> <buffer> <bar><bar>
\   <SID>IsAtStartOfLine('\|\|') ?
\   '<cmd>TableModeEnable<cr><cmd>TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'

function! s:IsAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction
