call plug#begin('~/.vim/plugged')

"----------Coc family----------
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

"----------Linting & Fixing----------
Plug 'dense-analysis/ale'

"----------Git----------
Plug 'tpope/vim-fugitive'

"----------Tags----------
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim'

"----------Stausline----------
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline'] }
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'maximbaz/lightline-ale'

"----------Window & Buffer & Keybindings----------
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'fholgado/minibufexpl.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Delete buffers and close files in Vim without closing windows and tabs
Plug 'moll/vim-bbye'

"----------Colorscheme----------
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
" Plug 'liuchengxu/space-vim-dark'
Plug 'ayu-theme/ayu-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }

"----------Highlighting----------
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'vim-scripts/SyntaxAttr.vim'

"----------Search & Move----------
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'justinmk/vim-sneak'

"----------Comment & Surround & Parenthsis----------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " repeat plugin map with '.', work with vim-surround
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'

"----------Snippets----------
" Plug 'SirVer/ultisnips'
Plug 'againxx/vim-snippets'

"----------Python----------
Plug 'tmhedberg/SimpylFold'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'againxx/python-syntax', { 'for': 'python' }

"----------Cpp----------
" Switch between header and source file
Plug 'vim-scripts/a.vim', { 'for': 'cpp' }

"----------Markdwon----------
" this plugin is needed by vim-markdown
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' } " use pre build
" This plugin is slow, loading only for markdown
Plug 'vim-scripts/fcitx.vim', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }

"----------Utility----------
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'tpope/vim-capslock'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-peekaboo' " Extand register and macro
Plug 'Konfekt/FastFold'
Plug 'AndrewRadev/switch.vim'

call plug#end()

" vimrc files
for s:path in split(glob('~/vim_zsh_tmux/vimrc/*.vim'), "\n")
    exe 'source ' . s:path
endfor
