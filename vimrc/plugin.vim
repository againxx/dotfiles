" Vim-plug
let g:plug_url_format = 'https://github.com/%s.git'

" Airline
let g:airline_theme = 'violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = '✖ '
let airline#extensions#ale#warning_symbol = '● '
let g:airline#extensions#whitespace#trailing_format = '%s'
let g:airline#extensions#whitespace#symbol = '✁'
let airline#extensions#ale#show_line_numbers = 0
let airline#extensions#tmuxline#color_template = 'normal'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
let g:airline_section_y = ''
let g:airline_section_warning= '%{airline#util#wrap(airline#extensions#whitespace#check(),0)} %{airline#util#wrap(airline#extensions#coc#get_warning(),0)}%{airline#util#wrap(airline#extensions#ale#get_warning(),0)}'
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
nmap y/ <Plug>(incsearch-fuzzy-/)
nmap y? <Plug>(incsearch-fuzzy-?)
nmap yg/ <Plug>(incsearch-fuzzy-stay)

" Sneak
" let g:sneak#label = 1

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
let g:ale_linters = {
\   'python': ['pylint'],
\   'cpp': ['ccls']
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}

" Vista
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_icon_indent = ["▸ ", ""]
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
  \ 'cpp': 'coc',
  \ 'python': 'coc',
  \ 'vim': 'ctags',
  \ }
let g:vista_close_on_jump = 1 
let g:vista_sidebar_width = 40
let g:vista_keep_fzf_colors = 1
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" let g:UltiSnipsExpandTrigger="<C-l>"
" let g:UltiSnipsJumpForwardTrigger="<Tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" coc-explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.vim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'rightside': {
\      'position': 'right',
\   },
\   'simplify': {
\     'file.root.template': '[icon] [title] [root] [fullpath]',
\     'file.child.template': '[selection | clip | 1] [indent][icon] [filename omitCenter 1]',
\   }
\ }

" vim-snippets
let g:ultisnips_python_quoting_style = 'double'
let g:ultisnips_python_triple_quoting_style = 'double'
let g:ultisnips_python_style = 'normal'

" custom highlight
hi Normal       ctermbg=NONE guibg=NONE
hi LineNr       ctermbg=NONE guibg=NONE
hi SignColumn   ctermbg=NONE guibg=NONE
hi CursorLineNr ctermbg=NONE guibg=NONE
hi pythonParam  ctermfg=174 guifg=#d78787 ctermbg=NONE guibg=NONE 
hi pythonSelf   ctermfg=103 guifg=#8787af ctermbg=NONE guibg=NONE 
hi ALEWarning   ctermbg=NONE guibg=NONE
hi CocHighlightText ctermbg=236 guibg=#34323e
