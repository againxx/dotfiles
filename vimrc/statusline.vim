let g:lightline = {}
let g:lightline.colorscheme = 'my_ayu_mirage'
let g:lightline.symbols = {
\   'linenr': ' ',
\   'colomnnr': '',
\   'beforemode': ' ',
\   'branch': '',
\   'whitespace': ' ',
\ }

let g:lightline#bufferline#min_buffer_count = 1
let g:lightline#bufferline#modified = ' ' " 
let g:lightline#bufferline#read_only = ' ' " 
let g:lightline#bufferline#unnamed = ''
let g:lightline#ale#indicator_checking = '...'
let g:lightline#ale#indicator_warnings = '● '
let g:lightline#ale#indicator_errors = '✖ '
let g:lightline#whitespace#trailing_format = '%s'

let g:lightline.active = {
\   'left': [['mode', 'paste'],
\            ['gitbranch'],
\            ['filename', 'readonly', 'cocstatus']],
\   'right': [['linter_checking', 'linter_errors', 'linter_warnings_with_whitespace_check'],
\             ['lineinfo'],
\             ['filetype']],
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
\   'spell': '%{&spell?&spelllang:""}',
\   'lineinfo': '%p%% %{g:lightline.symbols.linenr} %l %{g:lightline.symbols.colomnnr} %v',
\   'line': '%l',
\   'column': '%c',
\   'close': '%999X X ',
\   'winnr': '%{winnr()}'
\ }

let g:lightline.component_function = {
\   'filetype': 'LightlineFileTypeWithSymbol',
\   'gitbranch': 'LightlineCocGitBranch',
\   'cocstatus': 'coc#status',
\ }

let g:lightline.component_function_visible_condition = {
\   'readonly': '0',
\ }

let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers',
\   'linter_checking': 'lightline#ale#checking',
\   'linter_errors': 'lightline#ale#errors',
\   'readonly': 'LightlineReadonly',
\   'tabs': 'LightlineTabInfo',
\   'linter_warnings_with_whitespace_check': 'LightlineLinterWarningsWithWhitespaceCheck',
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

if exists("$WINDOWID") " Gnome-terminal don't set $WINDOWID
    let g:lightline.separator = {
    \   'left': '',
    \   'right': ''
    \ }
    let g:lightline.subseparator = {
    \   'left': '',
    \   'right': ''
    \ }
else
    let g:lightline.separator = {
    \   'left': '',
    \   'right': ''
    \ }
    let g:lightline.subseparator = {
    \   'left': '',
    \   'right': ''
    \ }
endif

function! LightlineFileTypeWithSymbol()
    let l:ftWithSymbol = &ft!=#""?&ft:"unknown"
    if &filetype == 'vim'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'python'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'cpp'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'markdown'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'cmake'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'help'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'list'
        let l:ftWithSymbol .= ' '
    elseif &filetype == 'vimwiki'
        let l:ftWithSymbol .= ' 龎'
    endif
    return l:ftWithSymbol
endfunction

function! LightlineCocGitBranch()
    let l:git_status = get(g:,'coc_git_status','')
    if strlen(l:git_status) > 0
        return g:lightline.symbols.branch . strcharpart(l:git_status, 1) .
        \   get(b:,'coc_git_status','') . get(b:,'coc_git_blame','')
    else
        return ''
    endif
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

function! LightlineLinterWarningsWithWhitespaceCheck()
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
