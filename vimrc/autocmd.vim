augroup python_filetype
    autocmd!
    autocmd FileType python setlocal foldlevel=1
    autocmd FileType python setlocal colorcolumn=101
    autocmd FileType python call coc#config('snippets.loadFromExtensions', 0)
    " dynamically set python.condaPath
    autocmd FileType python if !empty($CONDA_PREFIX) | call coc#config('python.condaPath', $CONDA_PREFIX.'/bin/python') | endif
    autocmd FileType python call CocAction('deactivateExtension', 'coc-zi')
    autocmd FileType python map <buffer> [f [m
    autocmd FileType python map <buffer> ]f ]m
    autocmd FileType python map <buffer> [F [M
    autocmd FileType python map <buffer> ]F ]M
    autocmd FileType python nnoremap <buffer> <Space><Space> 0/TODO<CR>:nohlsearch<CR>"_c4l
    autocmd FileType python nnoremap <buffer> [h
    \   {:execute "keepjumps normal! ?^\\(import\\<bar>from\\)\r"<CR>:nohlsearch<CR>
    autocmd FileType python nnoremap <buffer> ]h
    \   }:execute "keepjumps normal! /^\\(import\\<bar>from\\)\r"<CR>:nohlsearch<CR>:keepjumps normal }k<CR>
    autocmd FileType python let b:switch_custom_definitions = [
    \   {
    \       'print\s\+\(.*\)': 'print(\1)',
    \       'print(\([^)]*\))': 'print \1',
    \       'is\s\(not\)\@!': 'is not ',
    \       'is\snot': 'is',
    \   }
    \ ]
augroup END

augroup markdown_vimwiki_common
    autocmd!
    autocmd FileType markdown,vimwiki let b:coc_additional_keywords = ['\']
    autocmd FileType markdown,vimwiki call CocAction('reloadExtension', 'coc-zi')
    autocmd FileType markdown let b:coc_pairs_disabled = ['<']
    autocmd FileType markdown let g:vim_markdown_folding_disabled = 0
    autocmd FileType markdown let g:sneak#label = 0 | call sneak#init()
    " one or two spaces aren't considered as trailing
    autocmd FileType markdown let b:lightline_whitespace_trailing_regexp = '\( \{3,}\|\t\)$'
    autocmd FileType markdown nmap <buffer> [h <Plug>Markdown_MoveToCurHeader
    autocmd FileType markdown,vimwiki setlocal iskeyword+=92 conceallevel=2
    autocmd FileType markdown,vimwiki inoremap <buffer> ;w <Esc>/<++><CR>:nohlsearch<CR>"_c4l
    autocmd FileType markdown,vimwiki inoremap <buffer> ;e <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l
    autocmd FileType markdown,vimwiki inoremap <buffer> ;o <Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l<CR>
    autocmd FileType markdown,vimwiki inoremap <buffer> ;m $$<++><Esc>F$i
    autocmd FileType markdown,vimwiki inoremap <buffer> ;h $$<Space><Space>$$<Esc>2hi
    autocmd FileType markdown,vimwiki inoremap <buffer> ;c ``<Space><++><Esc>F`i
    autocmd FileType markdown,vimwiki inoremap <buffer> ;d -<Space>[<Space>]<Space>
    autocmd FileType markdown,vimwiki inoremap <buffer> ;n <Esc>A<Space>\\<CR>
    autocmd FileType markdown,vimwiki inoremap <buffer> ;; ;
    autocmd FileType markdown,vimwiki inoremap <buffer> ;q <Esc>/[)}\]]<CR>:nohlsearch<CR>a
    autocmd FileType markdown,vimwiki nnoremap <buffer> <Space><Space> /<++><CR>:nohlsearch<CR>"_c4l
    autocmd FileType markdown inoremap <buffer> ;b ****<Space><++><Esc>F*hi
    autocmd FileType markdown inoremap <buffer> ;s ~~~~<Space><++><Esc>F~hi
    autocmd FileType markdown inoremap <buffer> ;i **<Space><++><Esc>F*i
    autocmd FileType markdown inoremap <buffer> ;C ```<CR>```<Esc>ka
    autocmd FileType markdown inoremap <buffer> ;p ![](<++>)<Space><++><Esc>F[a
    autocmd FileType markdown inoremap <buffer> ;a [](<++>)<Space><++><Esc>F[a
    autocmd FileType markdown inoremap <buffer> ;r ##<Space>Reference<Esc>
    autocmd FileType markdown inoremap <buffer> ;M $$<CR>$$<Esc>O
    autocmd FileType markdown inoremap <buffer> ;1 #<Space>
    autocmd FileType markdown inoremap <buffer> ;2 ##<Space>
    autocmd FileType markdown inoremap <buffer> ;3 ###<Space>
    autocmd FileType markdown inoremap <buffer> ;4 ####<Space>
    autocmd FileType markdown if exists("b:match_words") | let b:match_words.=',\\begin{\w\+}:\\end{\w\+}' | endif
    autocmd FileType markdown,vimwiki let b:switch_custom_definitions = [
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
    " when vim-plug first load TableMode the cursor will be put in the first line,
    " use `. to jump to the original place
    autocmd FileType markdown,vimwiki inoreabbrev <expr> <buffer> <bar><bar>
    \   <SID>isAtStartOfLine('\|\|') ?
    \   '<c-o>:TableModeEnable<cr><c-o>`.<bar><space><bar><left><left>' : '<bar><bar>'
augroup END

augroup vimwiki_special
    autocmd!
    autocmd FileType vimwiki setlocal foldlevel=1
    autocmd FileType vimwiki let b:coc_pairs_disabled = ['[', '<']
    autocmd FileType vimwiki execute
    \   "autocmd User vim-which-key call which_key#register('gl', 'g:which_wikilist_lower_map')"
    autocmd FileType vimwiki execute
    \   "autocmd User vim-which-key call which_key#register('gL', 'g:which_wikilist_upper_map')"
    autocmd FileType vimwiki nnoremap <buffer> <silent> gl? :<C-u>WhichKey 'gl'<CR>
    autocmd FileType vimwiki nnoremap <buffer> <silent> gL? :<C-u>WhichKey 'gL'<CR>
    autocmd FileType vimwiki nmap <buffer> glt <Plug>VimwikiRemoveSingleCB
    autocmd FileType vimwiki nmap <buffer> gLt <Plug>VimwikiRemoveCBInList
    " VimwikiSearchTags will use locallist, disable ale to avoid conflict
    autocmd FileType vimwiki let b:ale_enabled = 0
    " Use vimwiki's folding method instead vim-markdown's
    autocmd FileType vimwiki let g:vim_markdown_folding_disabled = 1
    autocmd FileType vimwiki inoremap <buffer> ;t ::<Space><++><Esc>F:i
    autocmd FileType vimwiki if expand('%:e') == 'wiki' | call <SID>mapWikiSpecialMappings() | endif
    autocmd FileType vimwiki nnoremap <buffer> <silent> <space>t :<C-u>Tags<cr>
augroup END

augroup other_filetypes
    autocmd!
    autocmd FileType cpp setlocal foldmethod=syntax
    autocmd FileType cpp nnoremap <buffer> [h
    \   {:execute "keepjumps normal! ?^#include\r"<CR>:nohlsearch<CR>
    autocmd FileType cpp nnoremap <buffer> ]h
    \   }:execute "keepjumps normal! /^#include\r"<CR>:nohlsearch<CR>:keepjumps normal }k<CR>
    autocmd FileType fzf
    \   if has('nvim') && !exists('g:fzf_layout')
    \   |   set laststatus=0
    \   |   execute "autocmd BufLeave <buffer> set laststatus=2"
    \   | endif
augroup END

augroup common
    autocmd!
    autocmd BufReadPost *
    \   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \   |   exe "normal! g`\""
    \   | endif
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
    autocmd VimResized * :wincmd =
    " Close the preview window when completion is done
    autocmd CompleteDone * if pumvisible() == 0 && bufname('%') !=# '[Command Line]' | pclose | endif
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent if pumvisible() == 0 && &filetype !=# "cocactions"
    \   | call CocActionAsync('highlight') | endif
    autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd User vim-which-key call which_key#register('\', 'g:which_leader_map')
    autocmd User vim-which-key call which_key#register('<space>', 'g:which_space_map')
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
    " Update lightline before vista wipeout the sidebar buffer
    autocmd BufWipeout * call lightline#update()
    " Automatically close coc-explorer if it is the last window
    autocmd BufEnter * if winnr('$') == 1 && &filetype ==# 'coc-explorer' | q | endif
    autocmd CmdwinEnter * let b:coc_suggest_disable = 1
    autocmd BufEnter * if exists("b:ros_package_path") && &filetype ==# 'cpp' | call <SID>catkinInit() | endif
augroup END

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

function! s:mapWikiSpecialMappings() abort
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
endfunction

function! s:catkinInit() abort
    setlocal colorcolumn=121
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction
