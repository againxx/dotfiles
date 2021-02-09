scriptencoding utf-8
" ===
" === WhichKey
" ===
nnoremap <silent> <Leader> :<C-u>WhichKey '\'<CR>
vnoremap <silent> <Leader> :<C-u>WhichKeyVisual '\'<CR>
" Define prefix dictionary
let g:which_leader_map = {}
let g:which_leader_map.e = {
\   'name': '+edit',
\   'v':    'edit-vimrc',
\   'l':    'edit-leadermap',
\   'k':    'edit-keymap',
\   'p':    'edit-plugin-setting',
\   'a':    'edit-autocmd',
\   'g':    'edit-general-setting',
\   'b':    'edit-abbrev',
\   'c':    'edit-coc-config',
\   'C':    'edit-coc-local-config',
\   's':    'edit-snippets',
\   'm':    'edit-macro&register',
\   't':    'edit-local-task',
\   'T':    'edit-global-task',
\ }

let g:which_leader_map.d = {
\   'name': '+directory',
\   'v':    'vimrc-dir',
\   'c':    'current-dir',
\ }

let g:which_leader_map.s = {
\   'name': '+session/source',
\   's':    'session-save',
\   'l':    'session-load',
\   'v':    'source-vimrc',
\ }

let g:which_leader_map.q = {
\   'name': '+quit',
\   'q':    'only-quit-buffer',
\   'b':    'quit-buffer',
\   'w':    'wipeout-buffer',
\   't':    'quit-tab',
\   'd':    'quit-debugger',
\   'c':    'quit-quickfix',
\   'l':    'quit-location-list',
\ }

let g:which_leader_map.v = {
\   'name': '+view',
\   'm':    'markdown-preview',
\   'c':    'view-error-code',
\   'h':    'view-highlight-group',
\   'a':    'view-ascii-value',
\ }

let g:which_leader_map['\'] = {
\   'name': '+multi-cursor',
\   'j':    'select-cursor-down',
\   'k':    'select-cursor-up',
\   'A':    'select-all',
\   '\':    'add-cursor-at-pos',
\   '/':    'start-regex-search',
\ }

let g:which_leader_map.n = {
\   'name': '+new',
\   't':    'new-tab',
\   'd':    'new-todo',
\   'x':    'new-figlet-symbol',
\ }

let g:which_leader_map.c = {
\   'name': '+change',
\   'l':    'toggle-code-lens',
\   'b':    'toggle-git-blame',
\   'L':    'katex-left-equation',
\   'P':    'toggle-fzf-preview',
\   'S':    'change-statusline-sep',
\   's':    'toggle-check-spelling',
\   'p':    'change-build-profile',
\   'a':    'change-diagnostic-level',
\   'g':    'toggle-git-gutters',
\   'i':    'toggle-indent-line',
\   'w':    'toggle-wiki-autoreload'
\ }

let g:which_leader_map.t = {
\   'name': '+table/test/translate',
\   'm':    'table-toggle',
\   'r':    'table-realign',
\   'n':    'test-nearest',
\   'f':    'test-file',
\   's':    'test-suite',
\   'l':    'test-last',
\   'v':    'test-visit',
\   't':    'translate'
\ }

let g:which_leader_map.w = {
\   'name': '+wiki',
\   'w':    'default-wiki-index',
\   'T':    'default-wiki-index-in-new-tab',
\   's':    'select-and-open-wiki-index',
\   'x':    'delete-wiki-file',
\   'r':    'rename-wiki-file',
\   'n':    'notes-wiki-index',
\   'd':    'todo-wiki-index',
\   'g':    'generate-tag-links',
\   'tt':   'search-tag-under-current-cursor',
\   'ts':   'search-tags',
\   'b':    'search-back-links',
\   'B':    'generate-back-links',
\   'f':    'open-wiki-file',
\   'a':    'new-wiki-file',
\   'i':    'insert-note',
\ }

let g:which_leader_map.y = {
\   'name': '+yank',
\   'c': 'yank-diagnostic-code',
\ }

let g:which_leader_map.a = 'coc-actions'
let g:which_leader_map.f = 'coc-lists-grep'

" ===
" === Multi-visual
" ===
let g:VM_maps = {}
let g:VM_maps['Select Cursor Down'] = '<Leader><Leader>j'
let g:VM_maps['Select Cursor Up']   = '<Leader><Leader>k'

" ===
" === Edit files
" ===
nnoremap <Leader>ev :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/.vimrc')<CR>
nnoremap <Leader>el :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/leadermap.vim')<CR>
nnoremap <Leader>ek :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/keymap.vim')<CR>
nnoremap <Leader>ep :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/plugin.vim')<CR>
nnoremap <Leader>ea :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/autocmd.vim')<CR>
nnoremap <Leader>eg :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/general.vim')<CR>
nnoremap <Leader>eb :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/abbrev.vim')<CR>
nnoremap <Leader>ec :<C-u>CocConfig<CR>
nnoremap <Leader>eC :<C-u>CocLocalConfig<CR>
" nnoremap <Leader>es :CocCommand snippets.editSnippets<CR>
nnoremap <Leader>es :<C-u>UltiSnipsEdit!<CR>
nnoremap <Leader>em :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>
nnoremap <Leader>et :<C-u>AsyncTaskEdit<CR>
nnoremap <Leader>eT :<C-u>AsyncTaskEdit!<CR>

" ===
" === Change directory
" ===
nnoremap <Leader>dv :<C-u>cd ~/dotfiles/vimrc<CR>
nnoremap <Leader>dc :<C-u>cd %:p:h<CR>

" ===
" === Session & Source
" ===
nnoremap <Leader>ss :<C-u>CocCommand session.save<CR>
nnoremap <Leader>sl :<C-u>CocCommand session.load<CR>
" Source vimrc file
nnoremap <silent> <Leader>sv :<C-u>source $MYVIMRC<CR>:nohlsearch<CR>

" ===
" === Quit
" ===
nnoremap <silent> <Leader>qq :silent! Bdelete!<CR>:redrawtabline<CR>
nnoremap <silent> <Leader>qb :silent! bdelete!<CR>
nnoremap <silent> <Leader>qw :silent! bwipeout!<CR>
nnoremap <silent> <Leader>qt :tabclose<CR>
nnoremap <silent> <Leader>qd :VimspectorReset<CR>
nnoremap <silent> <Leader>qc :cclose<CR>
nnoremap <silent> <Leader>ql :lclose<CR>

" ===
" === Coc
" ===
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)

" ===
" === View
" ===
nnoremap <silent> <Leader>vc :<C-u>call <SID>toggleCocErrorCode()<CR>
nnoremap <Leader>vm :<C-u>MarkdownPreview<CR>
nnoremap <Leader>vh :<C-u>call SyntaxAttr()<CR>
nnoremap <Leader>va ga
vnoremap <Leader>va y:call <SID>echoFormatsAndChar(@0)<CR>

" ===
" === New
" ===
nnoremap <Leader>nt :tabnew %<CR>
nnoremap <Leader>nd :<C-u>CocCommand todolist.create<CR>
nnoremap <Leader>nx :read !figlet<Space>

" ===
" === Change settings
" ===
nnoremap <Leader>cL :<C-u>call <SID>toggleEquationFlushedLeft()<CR>
nnoremap <Leader>cP :<C-u>call <SID>toggleFZFPreview()<CR>
nnoremap <silent> <Leader>cS :<C-u>call <SID>toggleLightlineSep()<CR>
" nnoremap <silent> <Leader>cs :call <SID>toggleSpellChecking()<CR>
nnoremap <silent> <Leader>cs :<C-u>CocCommand cSpell.toggleEnableSpellChecker<CR>
nnoremap <Leader>cl :<C-u>call <SID>toggleCodeLens()<CR>
nnoremap <Leader>cb :<C-u>call <SID>toggleGitBlame()<CR>
nnoremap <Leader>cp :<C-u>call <SID>changeBuildProfile()<CR>
" enter and exit insert mode to update diagnostics
nnoremap <Leader>ca :<C-u>call <SID>changeDiagnosticLevel()<CR>i<Esc>
nnoremap <Leader>cg :<C-u>CocCommand git.toggleGutters<CR>
" nmap <Leader>ci <Plug>IndentGuidesToggle
nnoremap <Leader>ci :<C-u>IndentLinesToggle<CR>

" ===
" === Table-mode
" ===
nnoremap <Leader>tm :<C-u>TableModeToggle<CR>
let g:table_mode_realign_map = '<Leader>tr'

" ===
" === Vimwiki
" ===
nnoremap <Leader>ww :<C-u>VimwikiIndex<CR>:cd %:p:h<CR>:CocList files<CR>
nmap <Leader>wT <Plug>VimwikiTabIndex
nnoremap <Leader>wn :<C-u>VimwikiIndex 2<CR>
nnoremap <Leader>wd :<C-u>VimwikiIndex 3<CR>
nnoremap <Leader>wx <Plug>VimwikiDeleteLink
nnoremap <Leader>wg :<C-u>VimwikiGenerateTagLinks<CR>
nnoremap <Leader>wtt :<C-u>execute 'VimwikiSearchTags '.expand('<cword>')<Bar>CocList -A --normal locationlist<CR>
nnoremap <Leader>wts :<C-u>VimwikiSearchTags<Space>
nnoremap <Leader>wb :<C-u>VimwikiBacklinks<CR>:lclose<CR>:CocList -A --normal locationlist<CR>
nnoremap <Leader>wB :<C-u>ZettelBackLinks<CR>
nnoremap <Leader>wf :<C-u>ZettelOpen<CR>
nnoremap <Leader>wa :<C-u>ZettelNew<Space>
nnoremap <Leader>wi :<C-u>ZettelInsertNote<CR>

" ===
" === Test
" ===
nnoremap <silent> <Leader>tn :<C-u>TestNearest<CR>
nnoremap <silent> <Leader>tf :<C-u>TestFile<CR>
nnoremap <silent> <Leader>ts :<C-u>TestSuite<CR>
nnoremap <silent> <Leader>tl :<C-u>TestLast<CR>
nnoremap <silent> <Leader>tv :<C-u>TestVisit<CR>

" ===
" ===  coc-translator
" ===
" popup
nmap <Leader>tt <Plug>(coc-translator-p)
vmap <Leader>tt <Plug>(coc-translator-pv)

" ===
" === Yank
" ===
nnoremap <silent> <Leader>yc :<C-u>call <SID>yankDiagnosticCodes()<CR>

" ===
" === Functions
" ===

function! s:autoVerticalSplit(fname)
    if winlayout()[0] ==# 'leaf'
        exec 'vsplit '.a:fname
    else
        exec 'edit '.a:fname
    endif
endfunction

" Ale
" Reset b:ale_echo_msg_format to show error code
function! s:toggleAleErrorCode() abort
    if exists('b:ale_echo_msg_format')
        unlet b:ale_echo_msg_format
    else
        let b:ale_echo_msg_format = '[%linter%] %s [%severity%] # Disable: %code% #'
    endif
endfunction

" Coc
function! s:toggleCocErrorCode() abort
    if coc#util#get_config('diagnostic')['format'] ==# "%message\n[%source]"
        call coc#config('diagnostic.format', "%message\n[%source:%code]")
    else
        call coc#config('diagnostic.format', "%message\n[%source]")
    endif
endfunction

function! s:changeDiagnosticLevel() abort
    if coc#util#get_config('diagnostic')['level'] ==# 'warning'
        call coc#config('diagnostic.level', 'hint')
    else
        call coc#config('diagnostic.level', 'warning')
    endif
endfunction

" Markdown-Preview
function! s:toggleEquationFlushedLeft() abort
    if exists("g:mkdp_preview_options['katex']['fleqn']")
        if g:mkdp_preview_options['katex']['fleqn'] == 1
            let g:mkdp_preview_options['katex']['fleqn'] = 0
        else
            let g:mkdp_preview_options['katex']['fleqn'] = 1
        endif
    else
        let g:mkdp_preview_options['katex'] = {'fleqn': 1}
    endif
endfunction

" FZF-Preview
function! s:toggleFZFPreview() abort
    if exists('g:vista_fzf_preview')
        unlet g:vista_fzf_preview
        unlet g:fzf_layout
    else
        let g:vista_fzf_preview = ['up:60%']
        let g:fzf_layout = {
        \   'window': {
        \       'width': 0.9,
        \       'height': 0.9,
        \       'xoffset': 0.5,
        \       'border': 'sharp'
        \   }
        \ }
    endif
endfunction

" Lightline Separate
function! s:toggleLightlineSep() abort
    if g:lightline.separator.left == ''
        let g:lightline.separator = {
        \   'left': '',
        \   'right': ''
        \ }
        let g:lightline.subseparator = {
        \   'left': '',
        \   'right': ''
        \ }
    elseif g:lightline.separator.left == ''
        let g:lightline.separator = {
        \   'left': ' ',
        \   'right': ' '
        \ }
        let g:lightline.subseparator = {
        \   'left': '¦',
        \   'right': '¦'
        \ }
    else
        let g:lightline.separator = {
        \   'left': '',
        \   'right': ''
        \ }
        let g:lightline.subseparator = {
        \   'left': '',
        \   'right': ''
        \ }
    endif
    call lightline#toggle()
    call lightline#toggle()
endfunction

function! s:toggleSpellChecking() abort
    if &l:spell ==# 0
        setlocal spell spelllang=en_us
    else
        setlocal nospell
    endif
endfunction

function! s:toggleCodeLens() abort
    if coc#util#get_config('codeLens')['enable']
        call coc#config('codeLens.enable', 0)
    else
        call coc#config('codeLens.enable', 1)
    endif
endfunction

function! s:toggleGitBlame() abort
    if coc#util#get_config('git')['addGBlameToVirtualText']
        call coc#config('git.addGBlameToVirtualText', 0)
    else
        call coc#config('git.addGBlameToVirtualText', 1)
    endif
endfunction

function s:changeBuildProfile() abort
    if g:asynctasks_profile ==# 'debug'
        execute 'AsyncTaskProfile release'
    elseif g:asynctasks_profile ==# 'release'
        execute 'AsyncTaskProfile release-debug'
    elseif g:asynctasks_profile ==# 'release-debug'
        execute 'AsyncTaskProfile debug'
    else
        echo 'Unknown current profile!'
    endif
endfunction

" echo different formats and the corresponding char for a given number
function! s:echoFormatsAndChar(num) abort
    let l:input_num = a:num
    let l:hex_reg = '\v^(\\x|0x|\\u|u\+)'
    if l:input_num =~? '\v^\d+$' " decimal
        let l:output_num = '0x' . printf('%x', l:input_num)
    else " hexdecimal
        if l:input_num =~? l:hex_reg
            let l:input_num = '0x' . substitute(l:input_num, l:hex_reg, '', 'g')
        else
            let l:input_num = '0x' . l:input_num
        endif
        let l:output_num = printf('%d', l:input_num)
    endif
    let @" = nr2char(l:output_num)
    echo '<' . l:input_num . '> ' . l:output_num . ' ' . @"
endfunction

function s:yankDiagnosticCodes() abort
    let codes = join(<SID>getDiagnosticCodes())
    let @@ = codes
    let @+ = codes
endfunction

function! s:getDiagnosticCodes() abort
    let coc_diagnostics = CocAction('diagnosticList')
    let current_line = line('.')
    let current_file_path = expand('%:p')
    let codes = []
    for diagnostic in coc_diagnostics
        if diagnostic.file ==# current_file_path && current_line == diagnostic.lnum
        \   && diagnostic.location.range.start.character < col('.')
        \   && col('.') <= diagnostic.location.range.end.character
            call add(codes, diagnostic.code)
        endif
    endfor
    return codes
endfunction
