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
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
nnoremap <silent> <M-p> :TmuxNavigatePrevious<CR>

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
nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>
nnoremap <silent><M-z> :MaximizerToggle!<CR>
vnoremap <silent><M-z> :MaximizerToggle!<CR>gv
inoremap <silent><M-z> <C-o>:MaximizerToggle!<CR>

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
nnoremap <silent> <Space><M-l> :<C-u>Snippets<CR>
let g:which_space_map['<M-l>'] = 'snippets'

" ===
" === Treesitter
" ===
lua <<EOF
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp', 'query', 'java', 'rust', 'python', 'lua'},
  highlight = {
    enable = true,
    disable = {'python'},
    custom_captures = {
      -- Highlight the error capture group with the "CocWarningSign" highlight group.
      ["error"] = "CocWarningSign",
    },
  },
  indent = {
    enable = true,
    disable = {'python'},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- Disable highlight for bracket
require 'nvim-treesitter.highlight'
local hlmap = vim.treesitter.highlighter.hl_map
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
EOF

set indentexpr=nvim_treesitter#indent()
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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
