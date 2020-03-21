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

" Switch between header and  source file
Plug 'vim-scripts/a.vim', { 'for': 'cpp' }

" Colorcheme & Highlighting
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'liuchengxu/space-vim-dark'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'againxx/python-syntax', { 'for': 'python' }

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
" Plug 'SirVer/ultisnips'
Plug 'againxx/vim-snippets'

" Multi cursors
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Markdwon
" this plugin is needed by vim-markdown
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' } " use pre build
" This plugin is slow, loading only for markdown
Plug 'vim-scripts/fcitx.vim', { 'for': 'markdown' }

call plug#end()

" vimrc files
for s:path in split(glob('~/vim_zsh_tmux/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor
