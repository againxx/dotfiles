setlocal foldlevel=1
setlocal iskeyword+=92 conceallevel=2
let b:coc_pairs_disabled = ['[', '<']
" VimwikiSearchTags will use locallist, disable ale to avoid conflict
let b:ale_enabled = 0
" Use vimwiki's folding method instead vim-markdown's
let g:vim_markdown_folding_disabled = 1
let b:coc_additional_keywords = ['\']
if !exists('b:key_delay')
    let b:key_delay = 20
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

augroup vimwiki_special
    autocmd!
    autocmd User vim-which-key call which_key#register('gl', 'g:which_wikilist_lower_map')
    autocmd User vim-which-key call which_key#register('gL', 'g:which_wikilist_upper_map')
augroup END

nnoremap <buffer> <silent> gl? :<C-u>WhichKey 'gl'<CR>
nnoremap <buffer> <silent> gL? :<C-u>WhichKey 'gL'<CR>
nmap <buffer> glt <Plug>VimwikiRemoveSingleCB
nmap <buffer> gLt <Plug>VimwikiRemoveCBInList
nnoremap <buffer> <silent> <space>t :<C-u>Tags<cr>
inoremap <buffer> ;t ::<Space><++><Esc>F:i
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
if expand('%:e') ==# 'wiki'
    inoremap <buffer> ;b **<Space><++><Esc>F*i
    inoremap <buffer> ;B *__*<Space><++><Esc>F_i
    inoremap <buffer> ;s ~~~~<Space><++><Esc>F~hi
    inoremap <buffer> ;i __<Space><++><Esc>F_i
    inoremap <buffer> ;C {{{<CR>}}}<Esc>ka
    inoremap <buffer> ;p {{<bar><++>}}<Space><++><Esc>F{a
    inoremap <buffer> ;a [[<bar><++>]]<Space><++><Esc>F[a
    inoremap <buffer> ;M {{$<CR>}}$<Esc>kA
    inoremap <buffer> ;r ==<Space>Reference<Space>==<Esc>
    inoremap <buffer> ;1 =<Space><Space>=<Space><++><Esc>F=hi
    inoremap <buffer> ;2 ==<Space><Space>==<Space><++><Esc>F=2hi
    inoremap <buffer> ;3 ===<Space><Space>===<Space><++><Esc>F=3hi
    inoremap <buffer> ;4 ====<Space><Space>====<Space><++><Esc>F=4hi
    " vim-zettel key mappings"
    imap <buffer> <silent> ;z [[<esc><Plug>ZettelSearchMap
    nmap <buffer> gy <Plug>ZettelYankNameMap
    xmap <buffer> gz <Plug>ZettelNewSelectedMap
    nmap <buffer> gZ <Plug>ZettelReplaceFileWithLink
endif

if executable('xdotool')
  if executable('xdotool')
    nnoremap <silent> <buffer> <space>ww :<C-u>call <SID>controlChromiumPage('ctrl+r')<CR>
    nnoremap <silent> <buffer> <space>wj :<C-u>call <SID>controlChromiumPage('Down', v:count1)<CR>
    nnoremap <silent> <buffer> <space>wk :<C-u>call <SID>controlChromiumPage('Up', v:count1)<CR>
    nnoremap <silent> <buffer> <space>wd :<C-u>call <SID>controlChromiumPage('Page_Down', v:count1)<CR>
    nnoremap <silent> <buffer> <space>wu :<C-u>call <SID>controlChromiumPage('Page_Up', v:count1)<CR>
    nnoremap <silent> <buffer> <space>wgg :<C-u>call <SID>controlChromiumPage('Home')<CR>
    nnoremap <Leader>cw :<C-u>call <SID>toggleWikiAutoReload()<CR>
  endif
endif

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

function! s:controlChromiumPage(key, ...) abort
    let current_window = system('xdotool getactivewindow')[:-2]
    let file_name = expand('%')
    let title =zettel#vimwiki#get_title(file_name)
    if title == ''
        " use the Zettel filename as title if it is empty
        let title = fnamemodify(file_name, ':t:r')
    endif
    let search_pattern = title . '.*Chromium'
    let target_window = system('xdotool search --onlyvisible --name ' . shellescape(search_pattern))[:-2]
    if target_window != ''
        let key_sequence = [a:key]
        if a:0 > 0
            call extend(key_sequence, repeat([a:key], a:1 - 1))
        endif
        call system('xdotool windowfocus ' . target_window . ' key ' . join(key_sequence))
        execute 'sleep ' . (len(key_sequence) * b:key_delay) . 'm'
        call system('xdotool windowfocus ' . current_window)
    endif
endfunction

function! s:toggleWikiAutoReload() abort
  let buffer_autocmds = split(execute('autocmd vimwiki_special BufWritePost <buffer>'), '\n')[1:]
  if empty(buffer_autocmds)
    autocmd vimwiki_special BufWritePost <buffer> call s:controlChromiumPage('ctrl+r')
    echohl MoreMsg | echo 'Auto reload turned on' | echohl NONE
  else
    autocmd! vimwiki_special BufWritePost <buffer>
    echohl WarningMsg | echo 'Auto reload turned off' | echohl NONE
  endif
endfunction
