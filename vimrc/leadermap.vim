" ===
" === WhichKey
" ===
nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '\'<CR>
" Define prefix dictionary
let g:which_leader_map =  {}
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
\   's':    'edit-snippets',
\   'm':    'edit-macro&register',
\   't':    'edit-task',
\ }

let g:which_leader_map.d = {
\   'name': '+directory',
\   'v':    'virmc-dir',
\   'c':    'current-dir',
\ }

let g:which_leader_map.q = {
\   'name': '+quit',
\   'q':    'quit-buffer',
\   'w':    'quit-buffer&window',
\   'W':    'wipeout-buffer&window',
\   't':    'quit-tab',
\   'd':    'quit-debugger',
\ }

let g:which_leader_map.r = {
\   'name': '+refactor/run',
\   'n':    'rename',
\   'f':    'format',
\   'x':    'fix',
\   's':    'run-select',
\   'a':    'run-all',
\ }

let g:which_leader_map.v = {
\   'name': '+view',
\   'm':    'markdown-preview',
\   'c':    'error-code',
\   'h':    'highlight-group',
\   'l':    'katex-equation-left',
\   'p':    'fzf-preview',
\   'i':    'indent-guides',
\   'a':    'ascii-value',
\   'g':    'git-chunkinfo',
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
\   'd':    'new-todo',
\   't':    'new-tab',
\   'x':    'new-figlet-symbol',
\ }

let g:which_leader_map.c = {
\   'name': '+change',
\   'l':    'left-equation',
\   'p':    'fzf-preview',
\   'S':    'statusline-sep',
\   's':    'check-spelling',
\ }

let g:which_leader_map.t = {
\   'name': '+table/toggle',
\   'm':    'table-toggle',
\   'r':    'table-realign',
\   'g':    'toggle-git-gutters',
\ }

let g:which_leader_map.w = {
\   'name': '+wiki',
\   'w':    'default wiki index',
\   't':    'default wiki index in new tab',
\   's':    'select and open wiki index',
\   'x':    'delete wiki file',
\   'r':    'rename wiki file',
\   'd':    'wiki todo',
\ }

let g:which_leader_map.a = 'coc-actions'
let g:which_leader_map.f = 'coc-lists-grep'

" ===
" === Multi-visual
" ===
let g:VM_maps = {}
let g:VM_maps['Select Cursor Down'] = '<leader><leader>j'
let g:VM_maps['Select Cursor Up']   = '<leader><leader>k'

" Source vimrc file
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

function! s:autoVerticalSplit(fname)
    if winlayout()[0] == 'leaf'
        exec 'vsplit '.a:fname
    else
        exec 'edit '.a:fname
    endif
endfunction

" ===
" === Edit files
" ===
nnoremap <leader>ev :call <SID>autoVerticalSplit('~/dotfiles/vimrc/.vimrc')<CR>
nnoremap <leader>el :call <SID>autoVerticalSplit('~/dotfiles/vimrc/leadermap.vim')<CR>
nnoremap <leader>ek :call <SID>autoVerticalSplit('~/dotfiles/vimrc/keymap.vim')<CR>
nnoremap <leader>ep :call <SID>autoVerticalSplit('~/dotfiles/vimrc/plugin.vim')<CR>
nnoremap <leader>ea :call <SID>autoVerticalSplit('~/dotfiles/vimrc/autocmd.vim')<CR>
nnoremap <leader>eg :call <SID>autoVerticalSplit('~/dotfiles/vimrc/general.vim')<CR>
nnoremap <leader>eb :call <SID>autoVerticalSplit('~/dotfiles/vimrc/abbrev.vim')<CR>
nnoremap <leader>ec :CocConfig<CR>
nnoremap <leader>es :CocCommand snippets.editSnippets<CR>
nnoremap <leader>em :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap <leader>et :AsyncTaskEdit<CR>

" ===
" === Change directory
" ===
nnoremap <leader>dv :cd ~/dotfiles/vimrc<CR>
nnoremap <leader>dc :cd %:p:h<CR>

" ===
" === Quit
" ===
nnoremap <silent> <leader>qq :silent! Bdelete!<CR>:redrawtabline<CR>
nnoremap <silent> <leader>qw :silent! bdelete!<CR>
nnoremap <silent> <leader>qW :silent! bwipeout!<CR>
nnoremap <silent> <leader>qt :tabclose<CR>
nnoremap <silent> <leader>qd :VimspectorReset<CR>
nnoremap <silent> <leader>qx :call <SID>deleteFinishedTerminalBuffers()<CR>

" ===
" === Coc
" ===
" Formatting selected code.
xmap <leader>rf <Plug>(coc-format-selected)
nmap <leader>rf <Plug>(coc-format-selected)
" nmap <leader>rf <Plug>(coc-refactor)
" Apply AutoFix to problem on the current line.
nmap <leader>rx <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" exec in terminal
noremap <silent> <leader>rs :CocCommand python.execSelectionInTerminal<CR>
noremap <silent> <leader>ra :CocCommand python.execInTerminal<CR>

" coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open '.a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open '.visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" coc-lists grep
vnoremap <leader>f :<C-u>call <SID>grepFromSelected(visualmode())<CR>
nnoremap <leader>f :<C-u>set operatorfunc=<SID>grepFromSelected<CR>g@

" ===
" === View
" ===
nnoremap <silent> <leader>vc :call <SID>toggleAleErrorCode()<CR>
nnoremap <leader>vm :MarkdownPreview<CR>
nnoremap <leader>vh :call SyntaxAttr()<CR>
nmap <leader>vi <Plug>IndentGuidesToggle
nnoremap <leader>va ga
vnoremap <leader>va y:call <SID>echoFormatsAndChar(@0)<CR>
" show chunk diff at current position
nmap <leader>vg <Plug>(coc-git-chunkinfo)

" ===
" === New
" ===
nnoremap <leader>nt :tabnew %<CR>
nnoremap <leader>nd :CocCommand todolist.create<CR>
nnoremap <leader>nx :read !figlet<space>

" ===
" === Change settings
" ===
nnoremap <leader>cl :call <SID>toggleEquationFlushedLeft()<CR>
nnoremap <leader>cp :call <SID>toggleFZFPreview()<CR>
nnoremap <silent> <leader>cS :call <SID>toggleLightlineSep()<CR>
nnoremap <silent> <leader>cs :call <SID>toggleSpellChecking()<CR>

" ===
" === Table-mode
" ===
nnoremap <leader>tm :TableModeToggle<CR>
nnoremap <leader>tg :CocCommand git.toggleGutters<CR>
let g:table_mode_realign_map = '<leader>tr'

" ===
" === Vimwiki
" ===
nnoremap <leader>ww :<C-u>VimwikiIndex<CR>:cd %:p:h<CR>:CocList files<CR>
nnoremap <leader>wd :<C-u>VimwikiIndex 2<CR>
nnoremap <leader>wx <Plug>VimwikiDeleteLink
" ===
" === Functions
" ===
function! s:grepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

" Ale
" Reset b:ale_echo_msg_format to show error code
function! s:toggleAleErrorCode() abort
    if exists("b:ale_echo_msg_format")
        unlet b:ale_echo_msg_format
    else
        let b:ale_echo_msg_format = '[%linter%] %s [%severity%] # Disable: %code% #'
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
    if exists("g:vista_fzf_preview")
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
    let l:termBuffers = filter(range(1, bufnr('$')), "getbufvar(v:val, '&buftype') ==# 'terminal'")
    for l:buffer in l:termBuffers
        let l:isRunning = has('terminal') ? term_getstatus(l:buffer) =~# 'running' :
                        \ has('nvim') ? jobwait([getbufvar(l:buffer, '&channel')], 0)[0] == -1 :
                        \ 0
        if !l:isRunning
            silent execute l:buffer.'bdelete!'
        endif
    endfor
endfunction

" show vim highlight group under cursor
" nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
