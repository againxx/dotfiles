if !has('nvim') | finish | endif

set inccommand=nosplit
if has('persistent_undo')
  set undofile
  if !isdirectory($HOME . '/.config/nvim/tmp/undo')
    call mkdir($HOME . '/.config/nvim/tmp/undo', 'p')
  endif
  set undodir=$HOME/.config/nvim/tmp/undo
endif

" speed up
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog  = '/usr/bin/python3'
let g:node_host_prog = '~/.config/yarn/global/node_modules/neovim/bin/cli.js'
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" use nvr as primary editor for lazygit
if executable('nvr')
  let $EDITOR = 'nvr -cc tabprevious'
  let $VISUAL = 'nvr -cc tabprevious'
endif

" Make <C-j> and <C-k> move faster, in vim these two keys are used for window
" navigation
nnoremap <C-j> 5j
nnoremap <C-k> 5k
xnoremap <C-j> 5j
xnoremap <C-k> 5k

" Physics plausible scrolling
nnoremap <silent> <M-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <M-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <M-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <M-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

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
nnoremap <M-,> <Cmd>bprevious<CR>
nnoremap <M-.> <Cmd>bnext<CR>
nnoremap <M-9> <Cmd>cprevious<CR>
nnoremap <M-0> <Cmd>cnext<CR>
nnoremap <M-z> <Cmd>MaximizerToggle!<CR>
vnoremap <M-z> <Cmd>MaximizerToggle!<CR>gv
inoremap <M-z> <Cmd>MaximizerToggle!<CR>

" ===
" === Window Split
" ===
nnoremap <C-w>l :rightbelow vsplit<CR>
nnoremap <C-w>h :leftabove vsplit<CR>
nnoremap <C-w>j :rightbelow split<CR>
nnoremap <C-w>k :leftabove split<CR>

" ===
" === Buffer Navigation
" ===
nmap <M-1> <Plug>lightline#bufferline#go(1)
nmap <M-2> <Plug>lightline#bufferline#go(2)
nmap <M-3> <Plug>lightline#bufferline#go(3)
nmap <M-4> <Plug>lightline#bufferline#go(4)
nmap <M-5> <Plug>lightline#bufferline#go(5)
nmap <M-6> <Plug>lightline#bufferline#go(6)

" ===
" === Snippet
" ===
" Use <M-j> for jump to next placeholder and <M-k> for jump to previous placeholder
let g:coc_snippet_next = '<M-j>'
let g:coc_snippet_prev = '<M-k>'
let g:UltiSnipsJumpForwardTrigger = '<M-j>'
let g:UltiSnipsJumpBackwardTrigger = '<M-k>'
let g:UltiSnipsListSnippets = '<M-l>'

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

lua require('treesitter_config')
lua require('telescope_config')

set indentexpr=nvim_treesitter#indent()
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    disabled = {
      "vim",
    },
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}
EOF
