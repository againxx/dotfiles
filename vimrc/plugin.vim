" Vim-plug
let g:plug_url_format = 'https://github.com/%s.git'

" ===
" === tmuxline
" ===
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

" ===
" === Undotree
" ===
let g:undotree_SetFocusWhenToggle = 1

let g:incsearch#auto_nohlsearch = 1

" ===
" === Visual-multi
" ===
let g:VM_set_statusline = 2
let g:VM_silent_exit = 1

" Sneak
" let g:sneak#label = 1

" ===
" === Rainbow
" ===
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle
" Disable it for CMake files, since it breaks cmake syntax highlighting
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\ }

" ===
" === Ale
" ===
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

" ===
" === Vista
" ===
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

" ===
" === Coc
" ===
" Extensions
let g:coc_global_extensions = [
\   'coc-json',
\   'coc-python',
\   'coc-yank',
\   'coc-lists',
\   'coc-git',
\   'coc-explorer',
\   'coc-actions',
\   'coc-cmake',
\   'coc-highlight',
\   'coc-pairs',
\   'coc-vimlsp',
\   'coc-snippets',
\   'coc-todolist',
\ ]

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

" ===
" === Python-special
" ===
let g:ultisnips_python_quoting_style = 'double'
let g:ultisnips_python_triple_quoting_style = 'double'
let g:ultisnips_python_style = 'normal'
" Python-syntax
let g:python_syntax_space_errors = 0

" ===
" === Markdown
" ===
" vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_new_list_item_indent = 0
" markdown-preview
let g:mkdp_refresh_slow = 1
let g:mkdp_auto_close = 0
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
let g:mkdp_markdown_css = $HOME.'/Git_Repo/markdown-tex/custom_css/markdown/solarized-light.css'
let g:mkdp_highlight_css = $HOME.'/Git_Repo/markdown-tex/custom_css/highlight/solarized-light.css'

" ===
" === vim-indent-guides
" ===
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

" ===
" === vimwiki
" ===
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
\   {
\       'path': '~/Documents/Notes',
\       'syntax': 'markdown',
\       'ext': '.md'
\   }
\ ]

let g:vimwiki_key_mappings = {
\   'table_format': 0,
\   'table_mappings': 0,
\ }
let g:vimwiki_folding = 'custom'
let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_table_auto_fmt = 0

" Suda.vim
let g:suda_smart_edit = 1
