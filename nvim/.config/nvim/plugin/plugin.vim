scriptencoding utf-8
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
\       'cpp': 0,
\   }
\ }

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
let g:mkdp_markdown_css = $HOME.'/dotfiles/custom_css/markdown/solarized-light.css'
let g:mkdp_highlight_css = $HOME.'/dotfiles/custom_css/highlight/solarized-light.css'

" ===
" === indent_blankline
" ===
let g:indent_blankline_char = '│'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_filetype_exclude = ['help', 'man']

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
\   'lists_return': 0
\ }
let g:vimwiki_folding = 'expr'
" let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_table_auto_fmt = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_markdown_link_ext = 1

" vim-zettel
let g:zettel_format = '%title-%y%m%d'
let g:zettel_default_mappings = 0
let g:zettel_fzf_options = ['--exact', '--tiebreak=end', '--preview-window=up:60%']

" taskwiki
let g:taskwiki_disable_concealcursor = 1
let g:taskwiki_data_location = '~/Documents/tasks'
let g:taskwiki_suppress_mappings = 1

" ===
" === Vim-slime
" ===
let g:slime_target = 'tmux'
let g:slime_paste_file = '$HOME/.local/share/nvim/.slime_paste'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}
let g:slime_python_ipython = 1

" ===
" === Miscellaneous
" ===

" Suda.vim
" ccls will generate cache directory due to this setting
let g:suda_smart_edit = 0

" tmuxline
let g:tmuxline_preset = 'nightly_fox'

" incsearch
let g:incsearch#auto_nohlsearch = 1
" let g:incsearch#separate_highlight = 1
" use very magic mode as default
" let g:incsearch#magic = '\v'

" Python-syntax
let g:python_syntax_space_errors = 0

" Sneak
" let g:sneak#label = 0
let g:sneak#f_reset = 0
let g:sneak#t_reset = 0
let g:sneak#prompt = '省'
" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
" let g:sneak#s_next = 1

" Quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_lazy_highlight = 1

" Matchup
let g:matchup_matchparen_nomode = 'i'
let g:matchup_matchparen_enabled = 0
let g:matchup_motion_enabled = 0

" Vim-tmux-navigator
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Vim-be-good
let g:vim_be_good_floating = 0

" Barbaric
" The IME to invoke for managing input languages (macos, fcitx, ibus, xkb-switch)
let g:barbaric_ime = 'fcitx'
let g:barbaric_fcitx_cmd = 'fcitx5-remote'
" The input method for Normal mode (as defined by `xkbswitch -g`, `ibus engine`, or `xkb-switch -p`)
let g:barbaric_default = '-c'

" Vim-table-mode
let g:table_mode_corner = '|'

" vim-maximizer
let g:maximizer_set_default_mapping = 0

" comfortable-motion
let g:comfortable_motion_scroll_down_key = 'j'
let g:comfortable_motion_scroll_up_key = 'k'
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.

" jupytext
let g:jupytext_fmt = 'py:percent'

" superman
cabbrev man <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Man" : "man"<CR>
