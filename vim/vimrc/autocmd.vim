augroup common
  autocmd!
  " Automatically relocate cursor position
  autocmd BufReadPost *
  \   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \   |   exe "normal! g`\""
  \   | endif
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
  autocmd VimResized * :wincmd =
  autocmd TabClosed * call s:DeleteFinishedTerminalBuffers()
  " fix vim script user command syntax highlighting
  " (should be unnecessary when https://github.com/vim/vim/issues/6587 is fixed)
  autocmd Syntax vim syn match vimUsrCmd '^\s*\zs\u\%(\w*\)\@>(\@!'
augroup END

augroup lightline_special
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  " Update lightline before vista wipeout the sidebar buffer
  autocmd BufWipeout * call lightline#update()
augroup END

augroup coc_special
  autocmd!
  " Close the preview window (not completion window, this is why pumvisible() == 0) when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent if pumvisible() == 0 && &filetype !=# 'cocactions'
  \   | call CocActionAsync('highlight') | endif
  autocmd CursorHoldI * silent if coc#float#has_float() == 0 && CocHasProvider('signature') | call CocActionAsync('showSignatureHelp') | endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Automatically close coc-explorer if it is the last window
  autocmd BufEnter * if winnr('$') == 1 && &filetype ==# 'coc-explorer' | q | endif
  autocmd CmdwinEnter * let b:coc_suggest_disable = 1
  autocmd BufReadPost * if &readonly | let b:coc_diagnostic_disable = 1 | endif
  " Show the nearest function in statusline automatically by vista
  autocmd User CocNvimInit call vista#RunForNearestMethodOrFunction()
augroup END

augroup visual_multi_special
  autocmd!
  autocmd User visual_multi_start call s:VMStart()
  autocmd User visual_multi_exit  call s:VMExit()
augroup END

augroup vim_which_key_special
  autocmd!
  autocmd User vim-which-key call which_key#register('\', 'g:which_localleader_map')
  autocmd User vim-which-key call which_key#register('<Space>', 'g:which_leader_map')
augroup END

augroup clap_special
  autocmd!
  autocmd FileType clap_input inoremap <silent> <buffer> <C-o> <Esc>
  autocmd FileType clap_input inoremap <silent> <buffer> <Esc> <Esc>:call clap#handler#exit()<CR>
augroup END

augroup other_filetypes
  autocmd!
  autocmd FileType asm,gitcommit setlocal nolist
  autocmd FileType asm setlocal filetype=gas
  autocmd FileType man nmap <buffer> <Space>/ <Plug>(incsearch-forward)^\s\+\zs
augroup END

function! s:DeleteFinishedTerminalBuffers() abort
  let term_buffers = filter(range(1, bufnr('$')), "getbufvar(v:val, '&buftype') ==# 'terminal'")
  for term_buffer in term_buffers
    let is_running = has('terminal') ? term_getstatus(term_buffer) =~# 'running' :
    \   has('nvim') ? jobwait([getbufvar(term_buffer, '&channel')], 0)[0] == -1 :
    \   0
    if !is_running
      silent execute term_buffer.'bdelete!'
    endif
  endfor
endfunction

function! s:VMStart() abort
  nmap <buffer> <C-j> <Plug>(VM-Add-Cursor-Down)
  nmap <buffer> <C-k> <Plug>(VM-Add-Cursor-Up)
  nmap <buffer> <C-l> <Plug>(VM-Single-Select-l)
  nmap <buffer> <C-h> <Plug>(VM-Single-Select-h)
  execute 'Searchlight!'
endfunction

function! s:VMExit() abort
  nunmap <buffer> <C-j>
  nunmap <buffer> <C-k>
  nunmap <buffer> <C-h>
  nunmap <buffer> <C-l>
  execute 'Searchlight'
endfunction
