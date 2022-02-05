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
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

augroup lsp_special
  autocmd!
  autocmd CursorHold *
  \   lua if not (vim.b.lsp_floating_preview and
  \     vim.api.nvim_win_is_valid(vim.b.lsp_floating_preview))
  \   then vim.diagnostic.open_float({scope = "cursor"}) end
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

augroup defx_file_explorer
  autocmd!
  autocmd VimEnter * ++once silent! autocmd! FileExplorer
  autocmd VimEnter * ++once if isdirectory(expand('<amatch>')) |
        \ bwipeout! | execute "DefxIcon" expand('<amatch>') |
        \ endif |
        \ execute(printf("autocmd defx_file_explorer BufEnter * %s",
        \ "call s:enter_dir_with_defx(expand('<amatch>'), expand('<abuf>'))"))
augroup END

function! s:enter_dir_with_defx(path, bufnr) abort
  if bufnr(a:path) == a:bufnr && isdirectory(a:path) && !&diff
    " git submodule opened by `:Git difftool -y` for vim-fugitive is treated as directory,
    " but vim-fugitive couldn't set &diff before BufEnter event, let us check it later:)
    call timer_start(0, {-> call('s:defer_check_dir', [a:path, a:bufnr])})
  endif
endfunction

function! s:defer_check_dir(path, bufnr) abort
  if isdirectory(a:path) && !&diff && a:bufnr == nvim_get_current_buf()
    BufferWipeout!
    execute "DefxIcon" a:path
  end
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
