" ===
" === Undotree
" ===
let g:undotree_SetFocusWhenToggle = 1
" let g:undotree_ShortIndicators = 1

" ===
" === Visual-multi
" ===
let g:VM_set_statusline = 2
let g:VM_silent_exit = 1

" ===
" === Rainbow
" ===
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle
" Disable it for CMake files, since it breaks cmake syntax highlighting
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\       'vimwiki': 0,
\       'fzf': 0,
\   }
\ }

" ===
" === Ale
" ===
let g:ale_sign_error = '->'
let g:ale_sign_warning = '--'
let g:ale_sign_info = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'python': ['pylint', 'mypy'],
\   'cpp': ['ccls', 'cppcheck', 'clangtidy'],
\   'sh': ['shellcheck']
\ }
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format']
\ }
let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--cache-dir=' . $HOME . '/.cache/mypy'
let g:ale_cpp_ccls_init_options = {"cache": {"directory": ".cache/ccls"}}
let g:ale_c_clangformat_options = '--style=file'
let g:ale_cpp_clangtidy_checks = ['*']

" ===
" === fzf
" ===
let g:fzf_layout = {
\   'window': {
\       'width': 0.9,
\       'height': 0.9,
\       'xoffset': 0.5,
\       'border': 'sharp'
\   }
\ }
let g:fzf_preview_window = ['up:60%', 'ctrl-/']

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
let g:vista#renderer#icons = {
\   'func': 'ﳣ ',
\   'function': 'ﳣ ',
\   'functions': 'ﳣ ',
\   'var': ' ',
\   'variable': ' ',
\   'variables': ' ',
\   'const': ' ',
\   'constant': ' ',
\   'constructor': ' ',
\   'method': ' ',
\   'package': ' ',
\   'packages': ' ',
\   'enum': ' ',
\   'enummember': ' ',
\   'enumerator': ' ',
\   'module': ' ',
\   'modules': ' ',
\   'type': '璉',
\   'typedef': '璉',
\   'types': '璉',
\   'field': '綠',
\   'fields': '綠',
\   'map': '壟',
\   'class': '囹',
\   'augroup': ' ',
\   'struct': 'פּ ',
\   'union': '謹',
\ }

" To enable fzf preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['up:60%']

" ===
" === vim-clap
" ===
let g:clap_theme = 'ayu'
let g:clap_enable_background_shadow = v:false

" ===
" === Ultisnips
" ===
let g:ulti_expand_res = 0

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
\   'coc-zi',
\   'coc-ci',
\   'coc-tasks',
\   'coc-spell-checker',
\   'coc-ultisnips',
\   'coc-omni',
\   'coc-sh',
\   'coc-translator',
\   'coc-clangd',
\   'coc-fzf-preview'
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

" coc-fzf-preview
let g:fzf_preview_fzf_preview_window_option = 'up:60%'
let $FZF_PREVIEW_PREVIEW_BAT_THEME='Dracula'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_preview_use_dev_icons = 1
let g:fzf_preview_git_files_command = 'git ls-files --exclude-standard $(git rev-parse --show-toplevel)'
let g:fzf_preview_preview_key_bindings = 'ctrl-a:toggle-all,ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-/:toggle-preview'
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_delta_command = "delta --paging=never --hunk-header-style=omit --line-numbers-left-format=\"{nm} \" --line-numbers-right-format=\"{np} \""
let g:fzf_preview_git_status_preview_command =
\   "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached -- {-1} | " .
\   g:fzf_preview_delta_command . " || " .
\   "[[ $(git diff -- {-1}) != \"\" ]] && git diff -- {-1} | " .
\   g:fzf_preview_delta_command . " || " .
\   g:fzf_preview_command

" ===
" === Python-special
" ===
let g:ultisnips_python_quoting_style = 'double'
let g:ultisnips_python_triple_quoting_style = 'double'
let g:ultisnips_python_style = 'stable-baselines'
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
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_guide_size = 1
" let g:indent_guides_start_level = 2
" let g:indent_guides_enable_on_vim_startup = 0
" let g:indent_guides_default_mapping = 0
" let g:indent_guides_exclude_filetypes = [
" \   'help',
" \   'coc-explorer',
" \   'vista',
" \   'fzf'
" \ ]

" ===
" === indentLine
" ===
let g:indentLine_setColors = 0
let g:indentLine_char = '│'
let g:indentLine_fileType = ['c', 'cpp', 'python', 'cmake', 'sh', 'zsh']
let g:indent_blankline_extra_indent_level = -1

" ===
" === vimwiki
" ===
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
\   {
\       'path': '~/Documents/Vimwiki/wiki',
\       'css_name': 'css/style.css',
\       'path_html': '~/Documents/Vimwiki/html',
\       'template_path': '~/Documents/Vimwiki/template',
\       'syntax': 'default',
\       'ext': '.wiki',
\       'links_space_char': '_',
\       'auto_tags': 1,
\       'auto_export': 1,
\       'nested_syntaxes': {'python': 'python', 'cpp': 'cpp'}
\   },
\   {
\       'path': '~/Documents/Notes',
\       'syntax': 'markdown',
\       'ext': '.md',
\       'links_space_char': '_',
\       'auto_tags': 1
\   },
\   {
\       'path': '~/Documents/Todos',
\       'syntax': 'markdown',
\       'ext': '.md',
\       'index': 'todo'
\   }
\ ]

let g:vimwiki_key_mappings = {
\   'table_format': 0,
\   'table_mappings': 0,
\ }
let g:vimwiki_folding = 'expr'
" let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_table_auto_fmt = 0
let g:vimwiki_hl_headers = 1

" vim-zettel
let g:zettel_format = "%title-%y%m%d"
let g:zettel_default_mappings = 0
let g:zettel_fzf_options = ['--exact', '--tiebreak=end', '--preview-window=up:50%']

" ===
" === Asyncrun
" ===
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = [
\   '.git',
\   '.svn',
\   '.root',
\   '.project',
\   '.hg'
\ ]
let g:asynctasks_config_name = ['.tasks', '.vim/.tasks']
let g:asynctasks_confirm = 0
let g:asynctasks_term_pos = 'tab'
let g:asynctasks_term_reuse = 1

" ===
" === Vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_sign_priority = {
  \    'vimspectorBP':         40,
  \    'vimspectorBPCond':     40,
  \    'vimspectorBPDisabled': 40,
  \    'vimspectorPC':         999,
  \    'vimspectorPCBP':       999,
  \ }

" ===
" === Vim-slime
" ===
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.config/nvim/tmp/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_python_ipython = 1

" ===
" === Rnvimr
" ===
" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
" Customize initial layout
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.8 * &columns)),
            \ 'height': float2nr(round(0.8 * &lines)),
            \ 'col': float2nr(round(0.1 * &columns)),
            \ 'row': float2nr(round(0.1 * &lines)),
            \ 'style': 'minimal' }

" ===
" === Miscellaneous
" ===
" Vim-plug
let g:plug_url_format = 'https://github.com/%s.git'

" Suda.vim
" ccls will generate cache directory due to this setting
let g:suda_smart_edit = 0

" tmuxline
let g:tmuxline_preset = 'nightly_fox'

" incsearch
let g:incsearch#auto_nohlsearch = 1
" use very magic mode as default
let g:incsearch#magic = '\v'

" Sneak
let g:sneak#label = 1
let g:sneak#prompt = '省'
" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" Quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_lazy_highlight = 1

" Matchup
let g:matchup_matchparen_nomode = 'i'

" Vim-tmux-navigator
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Vim-test
let g:test#python#runner = 'pytest'

" Vim-be-good
let g:vim_be_good_floating = 0

" Barbaric
" The IME to invoke for managing input languages (macos, fcitx, ibus, xkb-switch)
let g:barbaric_ime = 'ibus'
" The input method for Normal mode (as defined by `xkbswitch -g`, `ibus engine`, or `xkb-switch -p`)
let g:barbaric_default = 'xkb:us::eng'

" Vim-table-mode
let g:table_mode_corner = '|'

" vim-maximizer
let g:maximizer_set_default_mapping = 0
