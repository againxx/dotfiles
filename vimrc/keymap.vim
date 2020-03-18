" NERDTree
" map <F2> :NERDTreeToggle<CR>
nnoremap <silent> <space>e :CocCommand explorer<CR>

" Vista
map <F3> :Vista!!<CR>

" Minibufexpl
map <F11> :bp<CR>
map <F12> :bn<CR>

" Fold
" nnoremap <space> za

" window navigate
nnoremap <C-l> <c-w>l
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k

" Multi-visual
let g:VM_maps = {}
let g:VM_maps['Select Cursor Down'] = '\\j'
let g:VM_maps['Select Cursor Up']   = '\\k'

" Ale
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(ale_previous_wrap_error)
nmap <silent> ]g <Plug>(ale_next_wrap_error)

" Coc
" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" Use <Tab> to confirm completion
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<Tab>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Scroll floating window up and down
" nnoremap <expr><C-n> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-n>"
" nnoremap <expr><C-p> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-p>"

" coc-lists
nnoremap <silent> <space>r :<C-u>CocList -N mru -A<cr>
nnoremap <silent> <space>f :<C-u>CocList files<cr>
nnoremap <silent> <space>b :<C-u>CocList buffers<cr>
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
" Search coc commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Search vim commands
nnoremap <silent> <space>v :<C-u>CocList vimcommands<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>s :<C-u>Vista finder<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Show locationlist
nnoremap <silent> <space>l :<C-u>CocList --normal locationlist<cr>
nnoremap <silent> <space>h :<C-u>CocList helptags<cr>
nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR>
nnoremap <silent> <space>u :<C-u>CocList snippets<cr>
nnoremap <silent> <space>t :<C-u>CocList --normal todolist<cr>
nnoremap <silent> <space>k :<C-u>CocList maps<cr>
