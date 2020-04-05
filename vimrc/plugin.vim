" Vim-plug
let g:plug_url_format = 'https://github.com/%s.git'

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
" let g:NERDTreeWinPos = 'right'
" let g:NERDTreeWinSize = 30

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

" Visual-multi
let g:VM_set_statusline = 2
let g:VM_silent_exit = 1

" Sneak
" let g:sneak#label = 1

" Rainbow
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle
" Disable it for CMake files, since it breaks cmake syntax highlighting
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\ }

" Ale
let g:ale_sign_error = '->'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'python': ['pylint', 'mypy'],
\   'cpp': ['ccls']
\ }
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\ }

" Vista
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_icon_indent = ["▸ ", ""]
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
\   'cpp': 'coc',
\   'python': 'coc',
\   'vim': 'ctags'
\ }
let g:vista_close_on_jump = 1
let g:vista_sidebar_width = 40
" let g:fzf_colors = {
" \   'fg':      ['fg', 'Normal'],
" \   'bg':      ['bg', 'Normal'],
" \   'hl':      ['fg', 'Comment'],
" \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
" \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
" \   'hl+':     ['fg', 'Statement'],
" \   'info':    ['fg', 'PreProc'],
" \   'border':  ['fg', 'Ignore'],
" \   'prompt':  ['fg', 'Conditional'],
" \   'pointer': ['fg', 'Exception'],
" \   'marker':  ['fg', 'Keyword'],
" \   'spinner': ['fg', 'Label'],
" \   'header':  ['fg', 'Comment']
" \ }
" let g:vista_keep_fzf_colors = 1

let g:fzf_layout = {
\   'window': {
\       'width': 0.9,
\       'height': 0.9,
\       'xoffset': 0.5,
\       'border': 'sharp'
\   }
\ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['up:60%']

" Coc
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

" vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_new_list_item_indent = 0
" markdown-preview
let g:mkdp_refresh_slow = 1
let g:mkdp_preview_options = {
\   'mkit': {},
\   'katex': {'fleqn': 1},
\   'uml': {},
\   'maid': {},
\   'disable_sync_scroll': 0,
\   'sync_scroll_type': 'middle',
\   'hide_yaml_meta': 1,
\   'sequence_diagrams': {},
\   'flowchart_diagrams': {}
\ }
let g:mkdp_markdown_css = '/home/ustc-1314/Programming_Tools/markdown-tex/custom_css/markdown/solarized-light.css'
let g:mkdp_highlight_css = '/home/ustc-1314/Programming_Tools/markdown-tex/custom_css/highlight/solarized-light.css'

" vim-indent-guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_default_mapping = 0
let g:indent_guides_exclude_filetypes = [
\   'help',
\   'coc-explorer',
\   'vista',
\   'fzf'
\ ]
