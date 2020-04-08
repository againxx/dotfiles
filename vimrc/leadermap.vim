" ===
" === WhichKey
" ===
nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
" Define prefix dictionary
let g:which_leader_map =  {}
let g:which_leader_map.e = {
\   'name': '+edit',
\   'v':    'edit-vimrc',
\   'l':    'edit-leadermap',
\   'm':    'edit-keymap',
\   'p':    'edit-plugin-setting',
\   'a':    'edit-autocmd',
\   'g':    'edit-general-setting',
\   'b':    'edit-abbrev',
\   'c':    'edit-coc-config',
\   's':    'edit-snippets',
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
\   't':    'quit-tab',
\ }

let g:which_leader_map.r = {
\   'name': '+refactor',
\   'n':    'rename',
\   'f':    'format',
\   'x':    'fix',
\ }

let g:which_leader_map.v = {
\   'name': '+view',
\   'm':    'markdown-preview',
\   'c':    'error-code',
\   'h':    'highlight-group',
\   'l':    'katex-equation-left',
\   'p':    'fzf-preview',
\   'i':    'indent-guides',
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
\ }

let g:which_leader_map.c = {
\   'name': '+change',
\   'l':    'left-equation',
\   'p':    'fzf-preview',
\   's':    'statusline-sep',
\ }

let g:which_leader_map.t = {
\   'name': '+table',
\   'm':    'table-toggle',
\   'r':    'table-realign',
\ }

let g:which_leader_map.s = {
\   'name': '+save',
\   's':    'sudo save',
\ }

let g:which_leader_map.w = {
\   'name': '+wiki',
\   'w':    'default wiki index',
\   't':    'default wiki index in new tab',
\   's':    'select and open wiki index',
\   'd':    'delete wiki file',
\   'r':    'rename wiki file',
\ }

let g:which_leader_map.a = 'coc-actions'
let g:which_leader_map.f = 'coc-lists-grep'

" Sudo save
nnoremap <leader>ss :w !sudo tee %<CR>

" ===
" === Multi-visual
" ===
let g:VM_maps = {}
let g:VM_maps['Select Cursor Down'] = '<leader><leader>j'
let g:VM_maps['Select Cursor Up']   = '<leader><leader>k'

" Source vimrc file, refresh airline to show the arrow
" nnoremap <silent> <leader>sv :source $MYVIMRC <bar> AirlineRefresh<CR>
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
nnoremap <leader>ev :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/.vimrc')<CR>
nnoremap <leader>el :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/leadermap.vim')<CR>
nnoremap <leader>em :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/keymap.vim')<CR>
nnoremap <leader>ep :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/plugin.vim')<CR>
nnoremap <leader>ea :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/autocmd.vim')<CR>
nnoremap <leader>eg :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/general.vim')<CR>
nnoremap <leader>eb :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/abbrev.vim')<CR>
nnoremap <leader>ew :call <SID>autoVerticalSplit('~/vim_zsh_tmux/vimrc/wiki.vim')<CR>
nnoremap <leader>ec :CocConfig<CR>
nnoremap <leader>es :CocCommand snippets.editSnippets<CR>


" ===
" === Change directory
" ===
nnoremap <leader>dv :cd ~/vim_zsh_tmux/vimrc<CR>
nnoremap <leader>dc :cd %:p:h<CR>

" ===
" === Quit
" ===
nnoremap <silent> <leader>qq :silent! Bdelete!<CR>
nnoremap <silent> <leader>qw :silent! bdelete!<CR>
nnoremap <silent> <leader>qt :tabclose<CR>
" nnoremap <leader>qb :MBEbd<CR>

" ===
" === Coc
" ===
" Formatting selected code.
xmap <leader>rf <Plug>(coc-format-selected)
nmap <leader>rf <Plug>(coc-format-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>rx <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>rf <Plug>(coc-refactor)

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

" ===
" === New
" ===
nnoremap <leader>nt :tabnew %<CR>
nnoremap <leader>nd :CocCommand todolist.create<CR>

" ===
" === Change settings
" ===
nnoremap <leader>cl :call <SID>toggleEquationFlushedLeft()<CR>
nnoremap <leader>cp :call <SID>toggleFZFPreview()<CR>
nnoremap <silent> <leader>cs :call <SID>toggleAirlineSep()<CR>

" ===
" === Table-mode
" ===
nnoremap <leader>tm :TableModeToggle<CR>
let g:table_mode_realign_map = '<leader>tr'

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
function! s:toggleAleErrorCode()
    if exists("b:ale_echo_msg_format")
        unlet b:ale_echo_msg_format
    else
        let b:ale_echo_msg_format = '[%linter%] %s [%severity%] # Disable: %code% #'
    endif
endfunction

" Mardown-Preview
function! s:toggleEquationFlushedLeft()
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
function! s:toggleFZFPreview()
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

" Airline Separate
function! s:toggleAirlineSep()
    if g:airline_left_sep == ''
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
    elseif g:airline_left_sep == ''
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
    else
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
    endif
endfunction
