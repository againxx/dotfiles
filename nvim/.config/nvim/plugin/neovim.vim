" ===
" === Autocmd
" ===
augroup neovim_special
  autocmd!
  autocmd UIEnter * call OnUIEnter(deepcopy(v:event)) " Used by firenvim
augroup END

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
    set guifont=InconsolataLGC\ Nerd\ Font:h20
    set showtabline=0
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

" Firenvim settings
let g:firenvim_config = {
\   'localSettings': {
\       'https?://[^/]+\.notion\.so/': {
\           'takeover': 'never',
\           'priority': 1
\       },
\       'https?://tam.cmet.ustc.edu.cn/': {
\           'takeover': 'never',
\           'priority': 1
\       },
\   }
\ }
