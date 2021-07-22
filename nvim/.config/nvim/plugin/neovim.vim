" Make <C-j> and <C-k> move faster, in vim these two keys are used for window
" navigation
nnoremap <C-j> 5j
nnoremap <C-k> 5k
xnoremap <C-j> 5j
xnoremap <C-k> 5k

" Enhanced <C-l>, in vim this key is used for window navigation
nnoremap <C-l> :nohlsearch<CR>:<C-r>=has('diff')?'diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-l>

" Fast normal mode
noremap <M-n> :normal<Space>

" Fast substitute
nnoremap <M-s> :%s//g<Left><Left>
xnoremap <M-s> :s//g<Left><Left>

" exit terminal
tnoremap <C-o> <C-\><C-n>
" tnoremap <M-[> <C-\><C-n>
" tnoremap <M-[> <Esc>
" tnoremap <C-v><Esc> <Esc>

" ===
" === Window Navigate
" ===
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
let g:tmux_navigator_no_mappings = 1
nnoremap <M-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <M-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <M-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <M-l> <Cmd>TmuxNavigateRight<CR>
nnoremap <M-p> <Cmd>TmuxNavigatePrevious<CR>

" ===
" === Command-line Cursor Movement
" ===
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>
cnoremap <M-k> <S-Left>
cnoremap <M-j> <S-Right>

" ===
" === Window Resize
" ===
nnoremap <M-=> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-[> <C-w><
nnoremap <M-]> <C-w>>
nnoremap <M-z> <Cmd>MaximizerToggle!<CR>
vnoremap <M-z> <Cmd>MaximizerToggle!<CR>gv
inoremap <M-z> <Cmd>MaximizerToggle!<CR>

nnoremap <M-9> <Cmd>cprevious<CR>
nnoremap <M-0> <Cmd>cnext<CR>

" ===
" === Window Split
" ===
nnoremap <C-w>l <Cmd>rightbelow vnew +set\ nobuflisted<CR>
nnoremap <C-w>h <Cmd>leftabove vnew +set\ nobuflisted<CR>
nnoremap <C-w>j <Cmd>rightbelow new +set\ nobuflisted<CR>
nnoremap <C-w>k <Cmd>leftabove new +set\ nobuflisted<CR>
nnoremap <C-w><C-l> <Cmd>rightbelow vnew +set\ nobuflisted<CR>
nnoremap <C-w><C-h> <Cmd>leftabove vnew +set\ nobuflisted<CR>
nnoremap <C-w><C-j> <Cmd>rightbelow new +set\ nobuflisted<CR>
nnoremap <C-w><C-k> <Cmd>leftabove new +set\ nobuflisted<CR>

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
