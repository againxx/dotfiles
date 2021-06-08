scriptencoding utf-8
" Allow buffer switch without saving
set hidden
set lazyredraw
" Show (partial) command in status line.
set showcmd
" Show matching brackets.
set showmatch
" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase
" highlight all search matches
set hlsearch
set wildmenu
set wildmode=list:longest,full
set autoread
set noshowmode
set noruler
set number
set relativenumber
set backspace=indent,eol,start
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" set ttimeoutlen=100     " fcitx.vim / ibus

" Use the symbols for tab and trailing spaces
set list
set listchars=tab:▸\ ,trail:▫

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Different options for a particular file using modelines
set modeline
" set autochdir
set scrolloff=2
set cursorline
set mouse=a
set laststatus=2
set showtabline=2
set showbreak=╰─▸\ 
set diffopt+=vertical
set helplang=en

" Disable some error highlights for shell script
let g:sh_no_error = 1
" Set bash as default shell script language
let g:is_bash = 1
