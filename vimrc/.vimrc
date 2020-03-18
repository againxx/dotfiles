call plug#begin('~/.vim/plugged')
" Coc family
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Linting & Fixing
Plug 'dense-analysis/ale'

" Tags
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder

" Airline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

" Window & Buffer & Keybindings
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'fholgado/minibufexpl.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Colorcheme & Highlighting
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'liuchengxu/space-vim-dark'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'pboettch/vim-cmake-syntax'

" Search & Move & Text Object
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'justinmk/vim-sneak'
Plug 'michaeljsmith/vim-indent-object'

" Comment & Surround & Parenthsis
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " repeat plugin map with '.', work with vim-surround
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'

" Snippets
Plug 'againxx/vim-snippets'

" Multi cursors
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Markdwon
Plug 'godlygeek/tabular' " this plugin is needed by vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " use pre build
Plug 'vim-scripts/fcitx.vim'

call plug#end()

" vimrc files
for s:path in split(glob('~/vim_zsh_tmux/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor
