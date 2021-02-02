scriptencoding utf-8
let g:lightline = {}
let g:lightline.colorscheme = 'my_ayu_mirage'
let g:lightline.symbols = {
\   'linenr': ' ',
\   'colomnnr': '',
\   'beforemode': ' ',
\   'whitespace': ' ',
\   'spellcheck': '暈',
\   'error': 'ﲅ ',
\   'warning': 'ﲍ ',
\   'information': 'ﳃ ',
\   'function': 'ﳣ ',
\   'ros': ' ﮧ',
\ }

" Auto tabline has issue when using together with vista, you should explicitly set showtabline=2
" let g:lightline#bufferline#min_buffer_count = 1
let g:lightline#bufferline#modified = ' ' " 
let g:lightline#bufferline#read_only = ' ' " 
let g:lightline#bufferline#unnamed = ''
" let g:lightline#ale#indicator_checking = '...'
" let g:lightline#ale#indicator_warnings = '● '
" let g:lightline#ale#indicator_errors = '✖ '
let g:lightline#whitespace#trailing_format = '%s'

let g:lightline.active = {
\   'left': [['mode'],
\            ['git', 'spell'],
\            ['filename', 'readonly', 'coc_status_with_nearest_function']],
\   'right': [['linter_errors', 'linter_warnings_with_whitespace_check'],
\             ['lineinfo'],
\             ['filetype'],
\             ['ros_package_name']],
\ }

let g:lightline.inactive = {
\   'left': [['filename']],
\   'right': [['lineinfo'],
\             ['filetype']]
\ }

let g:lightline.tabline = {
\   'left': [['buffers']],
\   'right': [['tabs'], ['close']]
\ }

let g:lightline.component = {
\   'mode': '%{g:lightline.symbols.beforemode} %{lightline#mode()}',
\   'absolutepath': '%F',
\   'relativepath': '%f',
\   'filename': '%<%t',
\   'bufnum': '%n',
\   'paste': '%{&paste?"PASTE":""}',
\   'charvalue': '%b',
\   'charvaluehex': '%B',
\   'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
\   'fileformat': '%{&ff}',
\   'percentwin': '%P',
\   'spell': '%{&spell?g:lightline.symbols.spellcheck:""}',
\   'lineinfo': '%p%% %{g:lightline.symbols.linenr} %l %{g:lightline.symbols.colomnnr} %v',
\   'line': '%l',
\   'column': '%c',
\   'close': '%999X X ',
\   'winnr': '%{winnr()}',
\ }
let g:lightline.component_visible_condition = {
\   'spell': '0'
\ }

let g:lightline.component_function = {
\   'filetype': 'LightlineFileTypeWithSymbol',
\   'ros_package_name': 'LightlineRosPackageName',
\   'git': 'LightlineCocGit',
\   'coc_status_with_nearest_function': 'CocStatusWithNearestMethodOrFunction',
\ }

let g:lightline.component_function_visible_condition = {
\   'readonly': '0',
\ }

let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers',
\   'readonly': 'LightlineReadonly',
\   'tabs': 'LightlineTabInfo',
\   'linter_errors': 'LightlineCocLinterErrors',
\   'linter_warnings_with_whitespace_check': 'LightlineCocLinterWarningsWithWhitespaceCheck',
\ }

let g:lightline.component_type = {
\   'buffers': 'tabsel',
\   'linter_checking': 'warning',
\   'linter_errors': 'error',
\   'readonly': 'readonly',
\   'tabs': 'tabinfo',
\   'linter_warnings_with_whitespace_check': 'warning',
\ }

let g:lightline.mode_map = {
\   'n' : 'N',
\   'i' : 'I',
\   'R' : 'R',
\   'v' : 'V',
\   'V' : 'VL',
\   "\<C-v>": 'VB',
\   'c' : 'C',
\   's' : 'S',
\   'S' : 'SL',
\   "\<C-s>": 'SB',
\   't': 'T',
\ }

let g:lightline.separator = {
\   'left': ' ',
\   'right': ' '
\ }
let g:lightline.subseparator = {
\   'left': '¦',
\   'right': '¦'
\ }
" if exists("$WINDOWID") " Gnome-terminal don't set $WINDOWID
" let g:lightline.separator = {
" \   'left': '',
" \   'right': ''
" \ }
" let g:lightline.subseparator = {
" \   'left': '',
" \   'right': ''
" \ }

function! LightlineFileTypeWithSymbol()
    let ft_with_symbol = &filetype !=# '' ? &filetype : 'unknown'
    if &filetype ==# 'vim'
        let ft_with_symbol .= ' '
    elseif &filetype ==# 'cuda'
        let ft_with_symbol .= ' '
    elseif &filetype ==# 'help'
        let ft_with_symbol .= ' '
    elseif &filetype ==# 'list'
        let ft_with_symbol .= ' '
    elseif &filetype ==# 'vimwiki' || &filetype ==# 'vimwiki.markdown'
        let ft_with_symbol .= ' ﴬ' " 龎
    elseif &filetype ==# 'cmake'
        let ft_with_symbol .= ' '
    elseif &filetype ==# 'qf'
        let ft_with_symbol .= ' ' " 
    elseif &filetype ==# 'unknown'
        let ft_with_symbol .= ' '
    else
        let ft_with_symbol .= ' ' . WebDevIconsGetFileTypeSymbol()
    endif
    return ft_with_symbol
endfunction

function! LightlineRosPackageName()
    if exists('b:ros_package_name')
        let package_name_with_symbol = b:ros_package_name
    else
        let package_name_with_symbol = get(b:, 'catkin_package_name', '')
    endif
    let package_name_with_symbol .= !empty(package_name_with_symbol) ? g:lightline.symbols.ros  : ''
    return package_name_with_symbol
endfunction

function! LightlineCocGit()
    let l:git_blame = winwidth(0) > 120 ? get(b:, 'coc_git_blame', '') : ''
    return trim(get(g:, 'coc_git_status', '')) . get(b:,'coc_git_status','') . l:git_blame
endfunction

function! LightlineTabInfo()
    if tabpagenr('$') > 1
        return 'tab ' . tabpagenr() . '/' . tabpagenr('$')
    else
        return ''
    endif
endfunction

function! LightlineReadonly()
    return &readonly && &filetype !~# '\v(help|vista|coc-explorer)' ? '' : ''
endfunction

function! LightlineAleLinterWarningsWithWhitespaceCheck()
    if strlen(lightline#ale#checking()) > 0
        return ''
    else
        let l:warnings = lightline#ale#warnings()
        let l:whitespace = lightline#whitespace#check()
        if strlen(l:warnings) == 0
            return l:whitespace
        elseif strlen(l:whitespace) == 0
            return l:warnings
        else
            return l:whitespace.' '.l:warnings
        endif
    endif
endfunction

function! LightlineCocLinterWarningsWithWhitespaceCheck()
    let l:info = get(b:, 'coc_diagnostic_info', {})
    let l:whitespace = lightline#whitespace#check()
    if empty(l:info) | return l:whitespace | endif
    let l:msgs = [l:whitespace]
    if get(info, 'warning', 0)
        call add(msgs, g:lightline.symbols.warning . info['warning'])
    endif
    if get(info, 'information', 0)
        call add(msgs, g:lightline.symbols.information . info['information'])
    endif
    return trim(join(msgs))
endfunction

function! LightlineCocLinterErrors()
    let l:info = get(b:, 'coc_diagnostic_info', {})
    if get(info, 'error', 0)
        return g:lightline.symbols.error . info['error']
    endif
    return ''
endfunction

function! CocStatusWithNearestMethodOrFunction() abort
    let l:status = get(g:, 'coc_status', '')
    let l:nearest_function = get(b:, 'vista_nearest_method_or_function', '')
    let l:status .= !empty(l:nearest_function) ? ' ' . g:lightline.symbols['function'] . l:nearest_function : ''
    return l:status
endfunction
