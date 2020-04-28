call plug#begin('~/.vim/plugged')

" ===
" === Autocompletion
" ===
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" ===
" === Linting & Fixing
" ===
Plug 'dense-analysis/ale'

" ===
" === Debugger
" ===
Plug 'puremourning/vimspector', { 'do': './install_gadget.py --enable-c --enable-python' }

" ===
" === Git
" ===
Plug 'tpope/vim-fugitive'

" ===
" === Tags
" ===
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim'

" ===
" === Stausline
" ===
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'maximbaz/lightline-ale'
Plug 'againxx/lightline-utils'

" ===
" === Window & Buffer & Keybindings
" ===
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!'] }
" Delete buffers and close files in Vim without closing windows and tabs
Plug 'moll/vim-bbye'

" ===
" === Colorscheme
" ===
" Plug 'sonph/onehalf', { 'rtp': 'vim/' }
" Plug 'liuchengxu/space-vim-dark'
Plug 'ayu-theme/ayu-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }

" ===
" === Highlighting
" ===
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'againxx/python-syntax', { 'for': 'python' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

" ===
" === Search & Move
" ===
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'justinmk/vim-sneak'

" ===
" === Comment & Surround & Parenthsis
" ===
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " repeat plugin map with '.', work with vim-surround
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'andymass/vim-matchup'

" ===
" === Snippets
" ===
" Plug 'SirVer/ultisnips'
Plug 'againxx/vim-snippets'

" ===
" === Python
" ===
Plug 'tmhedberg/SimpylFold'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" ===
" === Cpp
" ===
" Switch between header and source file
Plug 'vim-scripts/a.vim', { 'for': 'cpp' }

" ===
" === Markdwon
" ===
" this plugin is needed by vim-markdown and can be used to align text
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' } " use pre build
" This plugin is slow, loading only for markdown
Plug 'vim-scripts/fcitx.vim', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'on': ['TableModeToggle', 'TableModeEnable'] }

" ===
" === Task system
" ===
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" ===
" === Tmux Integration
" ===
Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] }
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" ===
" === Utility
" ===
Plug 'mg979/vim-visual-multi' 
Plug 'tpope/vim-capslock'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-peekaboo' " Extand register and macro
Plug 'Konfekt/FastFold', { 'for': 'python' }
Plug 'AndrewRadev/switch.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'lambdalisue/suda.vim'
Plug 'jez/vim-superman'

call plug#end()

" vimrc files
for s:path in split(glob('~/vim_zsh_tmux/vimrc/*.vim'), "\n")
    exe 'source ' . s:path
endfor
