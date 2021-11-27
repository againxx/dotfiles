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
  " fix vim script user command syntax highlighting
  " (should be unnecessary when https://github.com/vim/vim/issues/6587 is fixed)
  autocmd Syntax vim syn match vimUsrCmd '^\s*\zs\u\%(\w*\)\@>(\@!'
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
  autocmd BufEnter *coc-explorer* if winnr('$') == 1 | q | endif
  autocmd BufHidden *coc-explorer* lua require'bufferline.state'.set_offset(0)
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

" augroup ros_special
"   autocmd!
"   autocmd BufRead,BufNewFile *
"   autocmd User visual_multi_exit  call s:VMExit()
" augroup END

augroup other_filetypes
  autocmd!
  autocmd FileType asm,gitcommit setlocal nolist
  autocmd FileType asm setlocal filetype=gas
  autocmd FileType qf setlocal nobuflisted
  autocmd FileType qf setlocal nolist
  autocmd FileType rnvimr tnoremap <buffer><silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
  autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END

augroup ros_filetype_detect
  autocmd!
  autocmd BufRead,BufNewFile *.launch set filetype=roslaunch
  autocmd BufRead,BufNewFile *.action set filetype=rosaction
  autocmd BufRead,BufNewFile *.msg    set filetype=rosmsg
  autocmd BufRead,BufNewFile *.srv    set filetype=rossrv
augroup END

augroup ui_special
  autocmd!
  autocmd UIEnter * call OnUIEnter(deepcopy(v:event)) " Used by firenvim
augroup END

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

function! s:IsFirenvimActive(event) abort
 if !exists('*nvim_get_chan_info')
  return 0
 endif
 let l:ui = nvim_get_chan_info(a:event.chan)
 return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
 \    l:ui.client.name =~? 'Firenvim'
endfunction

" Used by firenvim
function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    if g:colors_name ==# 'ayu'
      hi Normal guibg=#1F2430
    endif
    set guifont=FiraCode\ Nerd\ Font\ Mono:h20
    set showtabline=0
    set laststatus=0
    hi Pmenu      guibg=NONE
    hi PmenuSbar  guibg=NONE
    hi PmenuThumb guibg=NONE
    " Use Alt_=-,. to resize firenvim window
    nnoremap <M-=> :<C-u>silent! set lines+=5<CR>
    nnoremap <M--> :<C-u>silent! set lines-=5<CR>
    nnoremap <M-,> :<C-u>silent! set columns-=5<CR>
    nnoremap <M-.> :<C-u>silent! set columns+=5<CR>
  endif
endfunction
