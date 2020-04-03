" Vim-plug
let g:plug_url_format = 'https://github.com/%s.git'

" minibufexpl
" let g:miniBufExplorerAutoStart = 0
" let g:miniBufExplBuffersNeeded = 99

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#ale#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr= ' ' " ﱰ惡  塞
let g:airline_symbols.colomnnr = '' " 
let g:airline_symbols.beforemode = ' ' "       
let g:airline_symbols.branch = '' " שׂ
let airline#extensions#ale#error_symbol = '✖ '
let airline#extensions#ale#warning_symbol = '● ' " 
let g:airline#extensions#whitespace#trailing_format = '%s'
let g:airline#extensions#whitespace#symbol = '' " ✁
if exists("$WINDOWID") " Gnome-terminal don't set $WINDOWID
    let g:airline_left_sep = '' " 
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = '' "    
    let g:airline_right_alt_sep = ''
else
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
endif
let airline#extensions#ale#show_line_numbers = 0
let airline#extensions#tmuxline#color_template = 'normal'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_a = '%{g:airline_symbols.beforemode} %#__accent_bold#%{airline#util#wrap(airline#parts#mode(),0)}%#__restore__#%{airline#util#append(airline#parts#crypt(),0)}%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append(airline#extensions#keymap#status(),0)}%{airline#util#append(airline#parts#spell(),0)}%{airline#util#append("",0)}%{airline#util#append("",0)}%{airline#util#append(airline#parts#iminsert(),0)}'
let g:airline_section_b = "%{ChangeCocGitBranchSymbol()}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
let g:airline_section_x = '%{airline#util#prepend("",0)}%{airline#util#prepend(airline#extensions#vista#currenttag(),0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}%{AppendFileTypeSymbol()}'
let g:airline_section_y = ''
let g:airline_section_z = '%p%% %{g:airline_symbols.linenr} %#__accent_bold#%l %{g:airline_symbols.colomnnr} %v%#__restore__#'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#whitespace#check(),0)} '.
\   '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'.
\   '%{airline#util#wrap(airline#extensions#ale#get_warning(),0)}'
let g:airline_mode_map = {
\   '__'     : '-',
\   'c'      : 'C',
\   'i'      : 'I',
\   'ic'     : 'I',
\   'ix'     : 'I',
\   'n'      : 'N',
\   'multi'  : 'M',
\   'ni'     : 'N',
\   'no'     : 'N',
\   'R'      : 'R',
\   'Rv'     : 'R',
\   's'      : 'S',
\   'S'      : 'S',
\   ''     : 'S',
\   't'      : 'T',
\   'v'      : 'V',
\   'V'      : 'V',
\   ''     : 'V',
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
let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize = 30

" Onehalf
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

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
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_exclude_filetypes = [
\   'help',
\   'coc-explorer',
\   'vista',
\   'fzf'
\ ]

function! ChangeCocGitBranchSymbol()
    let l:original_status = get(g:,'coc_git_status','')
    if strlen(l:original_status) > 3
        return g:airline_symbols.branch . strpart(l:original_status, 3)
    else
        return ''
    endif
endfunction

function! AppendFileTypeSymbol()
    if &filetype == 'vim'
        return '  '
    elseif &filetype == 'python'
        return '  '
    elseif &filetype == 'cpp'
        return '  '
    elseif &filetype == 'markdown'
        return '  '
    elseif &filetype == 'cmake'
        return '  '
    else
        return ''
    endif
endfunction
