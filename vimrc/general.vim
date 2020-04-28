set lazyredraw
set hidden 		    " Allow buffer switch without saving
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set hlsearch		" highlight all search matches
set wildmenu
set wildmode=list:longest,full
set autoread
set noshowmode
set noruler
set number
set relativenumber
set backspace=indent,eol,start
" set foldmethod=indent
" set foldlevel=99      " unfold at begin
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" set cindent
" set laststatus=2 	" this value is now default 2, used by airline
set ttimeoutlen=100     " fcitx.im
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Different options for a particular file using modelines
set modeline
" set autochdir
set scrolloff=2
set cursorline
set mouse=a
set showtabline=2
