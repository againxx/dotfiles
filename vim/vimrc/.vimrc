call plug#begin('~/.vim/plugged')

" ===
" === Autocompletion
" ===
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" ===
" === Linting & Fixing
" ===
" Plug 'dense-analysis/ale'

" ===
" === Debugger
" ===
Plug 'puremourning/vimspector'

" ===
" === Test
" ===
Plug 'janko/vim-test'

" ===
" === Git
" ===
Plug 'tpope/vim-fugitive'

" ===
" === Filesystem
" ===
Plug 'kevinhwang91/rnvimr'

" ===
" === Tags
" ===
" Plug 'liuchengxu/vista.vim'
Plug 'againxx/vista.vim'

" ===
" === Fuzzy Finder
" ===
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim'
" Build the extra binary if cargo exists on your system.
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Plug 'zhyu/clap-tasks'
" Plug 'vn-ki/coc-clap'

" ===
" === Stausline
" ===
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'againxx/lightline-utils'
" Plug 'maximbaz/lightline-ale'

" ===
" === Window & Buffer & Keybindings
" ===
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!'] }
" Delete buffers and close files in Vim without closing windows and tabs
Plug 'moll/vim-bbye'

" ===
" === Colorscheme & Icon
" ===
" Plug 'sonph/onehalf', { 'rtp': 'vim/' }
" Plug 'liuchengxu/space-vim-dark'
Plug 'ayu-theme/ayu-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ryanoasis/vim-devicons'

" ===
" === Highlighting
" ===
Plug 'pboettch/vim-cmake-syntax'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'againxx/python-syntax'
Plug 'againxx/vim-valgrind'
Plug 'aklt/plantuml-syntax'
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': 'cpp' }
Plug 'PeterRincker/vim-searchlight' " highlight current search match
Plug 'chrisbra/Colorizer'
Plug 'kevinoid/vim-jsonc'

" ===
" === Search & Move
" ===
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope' " highlight for f & t
Plug 'yuttie/comfortable-motion.vim' " physically plausible motion

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
Plug 'SirVer/ultisnips'
Plug 'againxx/vim-snippets'

" ===
" === Python
" ===
Plug 'tmhedberg/SimpylFold'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'goerz/jupytext.vim'
" Plug 'fs111/pydoc.vim'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" ===
" === Cpp
" ===
" Switch between header and source file
" Plug 'vim-scripts/a.vim', { 'for': 'cpp' }
Plug 'skywind3000/vim-cppman'

" ===
" === Assembly
" ===
Plug 'Shirk/vim-gas'

" ===
" === Markdown
" ===
" this plugin is needed by vim-markdown and can be used to align text
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " use pre build
" This plugin is slow, loading only for markdown
" Plug 'vim-scripts/fcitx.vim', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'on': ['TableModeToggle', 'TableModeEnable'] }
" Plug 'jalvesaq/zotcite'

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
Plug 'wellle/tmux-complete.vim'

" ===
" === Wiki
" ===
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'michal-h21/vim-zettel'
Plug 'tools-life/taskwiki'
" Plug 'lordm/vim-browser-reload-linux'

" ===
" === Curosr & Alignment
" ===
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/vim-easy-align'

" ===
" === Documentation
" ===
" Read Unix man pages in vim
Plug 'jez/vim-superman'
" Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" Plug 'alx741/vinfo'
Plug 'HiPhish/info.vim'

" ===
" === Utility
" ===
Plug 'tpope/vim-capslock'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
" Extand register and macro
" Plug 'junegunn/vim-peekaboo'
Plug 'Konfekt/FastFold', { 'for': 'python' }
Plug 'AndrewRadev/switch.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Automatically add sudo
Plug 'lambdalisue/suda.vim'
" Plug 'kevinhwang91/vim-ibus-sw'
Plug 'rlue/vim-barbaric', { 'for': ['markdown', 'vimwiki'] }
" Maximize and restore current window
Plug 'szw/vim-maximizer'
" Automatically switch to absolute numbers when relative numbers don't make sense
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Changes the working directory to the project root when you open a file or directory
" Plug 'airblade/vim-rooter'
" Work with variants of a word
Plug 'tpope/vim-abolish'
Plug 'danro/rename.vim'

" ===
" === Custom Text Objects
" ===
Plug 'kana/vim-textobj-user'
" Plug 'againxx/vim-textobj-underscore'
Plug 'Julian/vim-textobj-variable-segment'

" ===
" === ROS
" ===
if !empty($ROS_ROOT)
    Plug 'taketwo/vim-ros'
endif

" ===
" === Training Vim
" ===
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

" ===
" === Neovim Special
" ===
if has('nvim')
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " embed neovim in browser input box
    Plug 'lukas-reineke/indent-blankline.nvim'
endif

call plug#end()

" vimrc files
for s:path in split(glob('~/dotfiles/vim/vimrc/*.vim'), "\n")
    exe 'source ' . s:path
endfor
