scriptencoding utf-8
" ===
" === WhichKey
" ===
nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '\'<CR>
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
\   'c':    'error-code',
\   'h':    'highlight-group',
\   'i':    'indent',
\   'a':    'ascii-value',
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
\   'l':    'code-lens',
\   'b':    'git-blame',
\   'L':    'katex-left-equation',
\   'P':    'fzf-preview',
\   'S':    'statusline-sep',
\   's':    'check-spelling',
\   'p':    'build-profile',
\   'a':    'diagnostic-level',
\ }

let g:which_leader_map.t = {
\   'name': '+table/toggle/test/translate',
\   'm':    'table-toggle',
\   'r':    'table-realign',
\   'g':    'toggle-git-gutters',
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

let g:which_leader_map.a = 'coc-actions'
let g:which_leader_map.f = 'coc-lists-grep'

" ===
" === Multi-visual
" ===
let g:VM_maps = {}
let g:VM_maps['Select Cursor Down'] = '<leader><leader>j'
let g:VM_maps['Select Cursor Up']   = '<leader><leader>k'

" ===
" === Edit files
" ===
nnoremap <leader>ev :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/.vimrc')<CR>
nnoremap <leader>el :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/leadermap.vim')<CR>
nnoremap <leader>ek :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/keymap.vim')<CR>
nnoremap <leader>ep :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/plugin.vim')<CR>
nnoremap <leader>ea :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/autocmd.vim')<CR>
nnoremap <leader>eg :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/general.vim')<CR>
nnoremap <leader>eb :<C-u>call <SID>autoVerticalSplit('~/dotfiles/vimrc/abbrev.vim')<CR>
nnoremap <leader>ec :<C-u>CocConfig<CR>
nnoremap <leader>eC :<C-u>CocLocalConfig<CR>
" nnoremap <leader>es :CocCommand snippets.editSnippets<CR>
nnoremap <leader>es :<C-u>UltiSnipsEdit!<CR>
nnoremap <leader>em :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap <leader>et :<C-u>AsyncTaskEdit<CR>
nnoremap <leader>eT :<C-u>AsyncTaskEdit!<CR>

" ===
" === Change directory
" ===
nnoremap <leader>dv :<C-u>cd ~/dotfiles/vimrc<CR>
nnoremap <leader>dc :<C-u>cd %:p:h<CR>

" ===
" === Session & Source
" ===
nnoremap <leader>ss :<C-u>CocCommand session.save<CR>
nnoremap <leader>sl :<C-u>CocCommand session.load<CR>
" Source vimrc file
nnoremap <silent> <leader>sv :<C-u>source $MYVIMRC<CR>:nohlsearch<CR>

" ===
" === Quit
" ===
nnoremap <silent> <leader>qq :silent! Bdelete!<CR>:redrawtabline<CR>
nnoremap <silent> <leader>qb :silent! bdelete!<CR>
nnoremap <silent> <leader>qw :silent! bwipeout!<CR>
nnoremap <silent> <leader>qt :tabclose<CR>
nnoremap <silent> <leader>qd :VimspectorReset<CR>
nnoremap <silent> <leader>qx :call <SID>deleteFinishedTerminalBuffers()<CR>
nnoremap <silent> <leader>qc :cclose<CR>
nnoremap <silent> <leader>ql :lclose<CR>

" ===
" === Coc
" ===
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" ===
" === View
" ===
nnoremap <silent> <leader>vc :<C-u>call <SID>toggleCocErrorCode()<CR>
nnoremap <leader>vm :<C-u>MarkdownPreview<CR>
nnoremap <leader>vh :<C-u>call SyntaxAttr()<CR>
nnoremap <leader>va ga
vnoremap <leader>va y:call <SID>echoFormatsAndChar(@0)<CR>

" ===
" === New
" ===
nnoremap <leader>nt :tabnew %<CR>
nnoremap <leader>nd :<C-u>CocCommand todolist.create<CR>
nnoremap <leader>nx :read !figlet<space>

" ===
" === Change settings
" ===
nnoremap <leader>cL :<C-u>call <SID>toggleEquationFlushedLeft()<CR>
nnoremap <leader>cP :<C-u>call <SID>toggleFZFPreview()<CR>
nnoremap <silent> <leader>cS :<C-u>call <SID>toggleLightlineSep()<CR>
" nnoremap <silent> <leader>cs :call <SID>toggleSpellChecking()<CR>
nnoremap <silent> <leader>cs :<C-u>CocCommand cSpell.toggleEnableSpellChecker<CR>
nnoremap <leader>cl :<C-u>call <SID>toggleCodeLens()<CR>
nnoremap <leader>cb :<C-u>call <SID>toggleGitBlame()<CR>
nnoremap <leader>cp :<C-u>call <SID>changeBuildProfile()<CR>
" enter and exit insert mode to update diagnostics
nnoremap <leader>ca :<C-u>call <SID>changeDiagnosticLevel()<CR>i<Esc>
nnoremap <leader>cg :<C-u>CocCommand git.toggleGutters<CR>
" nmap <leader>ci <Plug>IndentGuidesToggle
nnoremap <leader>ci :<C-u>IndentLinesToggle<CR>

" ===
" === Table-mode
" ===
nnoremap <leader>tm :<C-u>TableModeToggle<CR>
let g:table_mode_realign_map = '<leader>tr'

" ===
" === Vimwiki
" ===
nnoremap <leader>ww :<C-u>VimwikiIndex<CR>:cd %:p:h<CR>:CocList files<CR>
nmap <leader>wT <Plug>VimwikiTabIndex
nnoremap <leader>wn :<C-u>VimwikiIndex 2<CR>
nnoremap <leader>wd :<C-u>VimwikiIndex 3<CR>
nnoremap <leader>wx <Plug>VimwikiDeleteLink
nnoremap <leader>wg :<C-u>VimwikiGenerateTagLinks<CR>
nnoremap <leader>wtt :<C-u>execute 'VimwikiSearchTags '.expand('<cword>')<bar>CocList -A --normal locationlist<cr>
nnoremap <leader>wts :<C-u>VimwikiSearchTags<Space>
nnoremap <leader>wb :<C-u>VimwikiBacklinks<CR>:lclose<CR>:CocList -A --normal locationlist<cr>
nnoremap <leader>wB :<C-u>ZettelBackLinks<CR>
nnoremap <leader>wf :<C-u>ZettelOpen<CR>
nnoremap <leader>wa :<C-u>ZettelNew<Space>
nnoremap <leader>wi :<C-u>ZettelInsertNote<CR>

" ===
" === Test
" ===
nnoremap <silent> <leader>tn :<C-u>TestNearest<CR>
nnoremap <silent> <leader>tf :<C-u>TestFile<CR>
nnoremap <silent> <leader>ts :<C-u>TestSuite<CR>
nnoremap <silent> <leader>tl :<C-u>TestLast<CR>
nnoremap <silent> <leader>tv :<C-u>TestVisit<CR>

" ===
" ===  coc-translator
" ===
" popup
nmap <leader>tt <Plug>(coc-translator-p)
vmap <leader>tt <Plug>(coc-translator-pv)

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

function! s:deleteFinishedTerminalBuffers() abort
    let l:term_buffers = filter(range(1, bufnr('$')), "getbufvar(v:val, '&buftype') ==# 'terminal'")
    for l:buffer in l:term_buffers
        let l:is_running = has('terminal') ? term_getstatus(l:buffer) =~# 'running' :
                        \ has('nvim') ? jobwait([getbufvar(l:buffer, '&channel')], 0)[0] == -1 :
                        \ 0
        if !l:is_running
            silent execute l:buffer.'bdelete!'
        endif
    endfor
endfunction
