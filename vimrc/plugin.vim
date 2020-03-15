" Airline
let g:airline_theme="violet"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let airline#extensions#tmuxline#color_template = 'normal'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
let g:airline_section_y = ''
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

" tmuxline
" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'c'    : '',
"       \'win'  : '#I #W',
"       \'cwin' : '#I #W',
"       \'x'    : '%a',
"       \'y'    : '#W %R',
"       \'z'    : '#H'}
let g:tmuxline_preset = 'nightly_fox'

" NERDTree
let NERDTreeWinPos='right'
let NERDTreeWinSize=30

" Onehalf
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

" Space-vim-dark
colorscheme space-vim-dark
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

" Incsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Rainbow
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle
" Disable it for CMake files, since it breaks cmake syntax highlighting
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

" Ale
let g:ale_sign_error = '->'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
hi ALEWarning ctermbg=235
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   'python': ['pylint'],
\}

" Coc
" Close the preview window when completion is done
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" hi link CocHighlightText StatusLine
hi CocHighlightText ctermbg=236
let g:coc_snippet_next = '<tab>'
