augroup python_filetype
    autocmd!
    autocmd FileType python setlocal foldlevel=1
    autocmd FileType python call coc#config('snippets.loadFromExtensions', 0)
    autocmd FileType python map <buffer> [f [m
    autocmd FileType python map <buffer> ]f ]m
    autocmd FileType python map <buffer> [F [M
    autocmd FileType python map <buffer> ]F ]M
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

augroup markdown_filetype
    autocmd!
    autocmd FileType markdown setlocal iskeyword+=92 conceallevel=2
    autocmd FileType markdown let b:coc_additional_keywords = ['\']
    autocmd FileType markdown let b:coc_pairs_disabled = ['<']
    " one or two spaces aren't considered as trailing
    autocmd FileType markdown let b:lightline_whitespace_trailing_regexp = '\( \{3,}\|\t\)$'
    autocmd FileType markdown nmap <buffer> [h <Plug>Markdown_MoveToCurHeader
    autocmd Filetype markdown inoremap <buffer> ;w <Esc>/<++><CR>:nohlsearch<CR>"_c4l
    autocmd Filetype markdown inoremap <buffer> ;e <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
    autocmd Filetype markdown inoremap <buffer> ;b **** <++><Esc>F*hi
    autocmd Filetype markdown inoremap <buffer> ;s ~~~~ <++><Esc>F~hi
    autocmd Filetype markdown inoremap <buffer> ;i ** <++><Esc>F*i
    autocmd Filetype markdown inoremap <buffer> ;c `` <++><Esc>F`i
    autocmd FileType markdown inoremap <buffer> ;m $$<++><Esc>F$i
    autocmd FileType markdown inoremap <buffer> ;M $$<CR>$$<Esc>O
    autocmd FileType markdown inoremap <buffer> ;C ```<CR>```<Esc>ka
    autocmd FileType markdown inoremap <buffer> ;d -<Space>[<Space>]<Space>
    autocmd Filetype markdown inoremap <buffer> ;p ![](<++>) <++><Esc>F[a
    autocmd Filetype markdown inoremap <buffer> ;a [](<++>) <++><Esc>F[a
    autocmd Filetype markdown inoremap <buffer> ;n <Esc>A<Space>\\<CR>
    autocmd Filetype markdown inoremap <buffer> ;q <Esc>/[)}\]]<CR>:nohlsearch<CR>a
    autocmd FileType markdown inoremap <buffer> ;; ;
    autocmd FileType markdown inoremap <buffer> ;1 #<Space>
    autocmd FileType markdown inoremap <buffer> ;2 ##<Space>
    autocmd FileType markdown inoremap <buffer> ;3 ###<Space>
    autocmd FileType markdown inoremap <buffer> ;4 ####<Space>
    autocmd FileType markdown nnoremap <buffer> <Space><Space> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
    autocmd FileType markdown if exists("b:match_words") | let b:match_words.=',\\begin{\w\+}:\\end{\w\+}' | endif
    autocmd FileType markdown let b:switch_custom_definitions = [
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
    \   },
    \   ['\\rightarrow', '\\longrightarrow', '\\Rightarrow', '\\Longrightarrow'],
    \   ['\\leftarrow', '\\longleftarrow', '\\Leftarrow', '\\Longleftarrow'],
    \   ['\\leftrightarrow', '\\longleftrightarrow', '\\Leftrightarrow', '\\Longleftrightarrow', '\\iff'],
    \   ['\\hat', '\\tilde', '\\widehat', '\\widetilde', '\\overline', '\\bar'],
    \   ['- [ ]', '- [X]']
    \ ]
    " when vim-plug first load TableMode the cursor will be put in the first line,
    " use `. to jump to the original place
    autocmd FileType markdown inoreabbrev <expr> <buffer> <bar><bar>
    \   <SID>isAtStartOfLine('\|\|') ?
    \   '<c-o>:TableModeEnable<cr><c-o>`.<bar><space><bar><left><left>' : '<bar><bar>'
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
    \   | set laststatus=0
    \   | execute "autocmd BufLeave <buffer> set laststatus=2"
    \   | endif
    autocmd FileType vimwiki.markdown execute
    \   "autocmd User vim-which-key call which_key#register('gl', 'g:which_wikilist_lower_map')"
    autocmd FileType vimwiki.markdown execute
    \   "autocmd User vim-which-key call which_key#register('gL', 'g:which_wikilist_upper_map')"
    autocmd FileType vimwiki.markdown nnoremap <buffer> <silent> gl? :<C-u>WhichKey 'gl'<CR>
    autocmd FileType vimwiki.markdown nnoremap <buffer> <silent> gL? :<C-u>WhichKey 'gL'<CR>
    autocmd FIleType vimwiki.markdown nmap <buffer> glt <Plug>VimwikiRemoveSingleCB
    autocmd FIleType vimwiki.markdown nmap <buffer> gLt <Plug>VimwikiRemoveCBInList
    " autocmd FileType vim if bufname('%') == '[Command Line]' | let b:coc_suggest_disable = 1 | endif
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
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd User vim-which-key call which_key#register('\', 'g:which_leader_map')
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
    " Update lightline before vista wipeout the sidebar buffer
    autocmd BufWipeout * call lightline#update()
    " Automatically close coc-explorer if it is the last window
    autocmd BufEnter * if winnr('$') == 1 && &filetype ==# 'coc-explorer' | q | endif
    autocmd CmdwinEnter * let b:coc_suggest_disable = 1
augroup END

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction
