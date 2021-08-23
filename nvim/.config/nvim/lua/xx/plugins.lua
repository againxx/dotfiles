vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  ---
  --- LSP
  ---
  use { 'neoclide/coc.nvim', branch = 'release' }

  ---
  --- Debugger
  ---
  -- use 'puremourning/vimspector'
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use { "rcarriga/nvim-dap-ui", requires = { 'mfussenegger/nvim-dap' } }
  use { 'theHamsta/nvim-dap-virtual-text',  module = 'xx.dap' }
  use 'jbyuki/one-small-step-for-vimkind'

  ---
  --- Test
  ---
  use 'janko/vim-test'

  ---
  --- Git
  ---
  use 'tpope/vim-fugitive'
  use {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit'
  }

  ---
  --- Filesystem
  ---
  use 'kevinhwang91/rnvimr'

  ---
  --- Colorscheme & Icons
  ---
  use 'tjdevries/colorbuddy.nvim'
  use 'againxx/ayu-vim'
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        override = {
          wiki = {
            icon = '',
            color = '#F07178',
            name = 'Vimwiki'
          },
          pyi = {
            icon = '',
            color = '#77A8D9',
            name = 'Pyi'
          },
          cu = {
            icon = '',
            color = '#854CC7',
            name = 'Cuda'
          }
        },
        default = true;
      }
    end
  }

  ---
  --- Statusline
  ---
  use 'hoob3rt/lualine.nvim'
  use 'romgrk/barbar.nvim'

  ---
  --- Start Screen
  ---
  use 'glepnir/dashboard-nvim'

  ---
  --- Window & Buffer & Keybindings
  ---
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  ---
  --- Fuzzy Finder
  ---
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
  }
  use 'fannheyward/telescope-coc.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-fzf-writer.nvim'
  use 'GustavoKatel/telescope-asynctasks.nvim'
  use 'fhill2/telescope-ultisnips.nvim'
  use 'againxx/telescope-ros.nvim'
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = 'tami5/sql.nvim',
  }

  ---
  --- Highlighting
  ---
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'p00f/nvim-ts-rainbow'
  use 'pboettch/vim-cmake-syntax'
  use 'vim-scripts/SyntaxAttr.vim'
  use 'againxx/python-syntax'
  use 'againxx/vim-valgrind'
  use 'aklt/plantuml-syntax'
  use 'PeterRincker/vim-searchlight' -- highlight current search match
  use 'norcalli/nvim-terminal.lua' -- highlight terminal escape sequences
  use 'kevinoid/vim-jsonc'

  ---
  --- Search & Move
  ---
  use 'haya14busa/incsearch.vim'
  use 'justinmk/vim-sneak'
  use 'unblevable/quick-scope' -- highlight for f & t
  use 'karb94/neoscroll.nvim' -- smooth scrolling

  ---
  --- Comment & Surround & Parenthsis
  ---
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat' -- repeat plugin map with '.', work with vim-surround
  use 'tpope/vim-commentary'
  use 'luochen1990/rainbow'
  use 'andymass/vim-matchup'

  ---
  --- Snippets
  ---
  use 'SirVer/ultisnips'
  use 'againxx/vim-snippets'

  ---
  --- Python
  ---
  use 'michaeljsmith/vim-indent-object'
  use 'Vimjas/vim-python-pep8-indent'
  use 'goerz/jupytext.vim'

  ---
  --- Cpp
  ---
  use 'skywind3000/vim-cppman'

  ---
  --- Assembly
  ---
  use 'Shirk/vim-gas'

  ---
  --- Markdown
  ---
  -- this plugin is needed by vim-markdown and can be used to align text
  use { 'godlygeek/tabular', ft = 'markdown' }
  use 'plasticboy/vim-markdown'
  use {
    'iamcco/markdown-preview.nvim', ft = 'markdown',
    run = function() vim.fn['mkdp#util#install']() end
  } -- use pre build
  use {
    'dhruvasagar/vim-table-mode', cmd = {'TableModeToggle', 'TableModeEnable'}
  }

  ---
  --- Wiki
  ---
  use { 'vimwiki/vimwiki', branch = 'dev' }
  use 'tools-life/taskwiki'
  use {
    'michal-h21/vim-zettel',
    ft = 'vimwiki',
    requires = {
      { 'junegunn/fzf', ft = 'vimwiki' },
      { 'junegunn/fzf.vim', ft = 'vimwiki' },
    },
    config = function() require('xx.fzf') end
  }

  ---
  --- Task system
  ---
  use 'skywind3000/asynctasks.vim'
  use 'skywind3000/asyncrun.vim'

  ---
  --- Tmux Integration
  ---
  use {
    'edkolev/tmuxline.vim', cmd = {'Tmuxline', 'TmuxlineSnapshot'}
  }
  use 'christoomey/vim-tmux-navigator'
  use 'jpalardy/vim-slime'
  use 'wellle/tmux-complete.vim'

  ---
  --- Curosr & Alignment
  ---
  use 'mg979/vim-visual-multi'
  use 'junegunn/vim-easy-align'

  ---
  --- Documentation
  ---
  -- Read Unix man pages in vim
  use 'jez/vim-superman'
  use 'HiPhish/info.vim'

  ---
  --- Custom Text Objects
  ---
  use 'kana/vim-textobj-user'
  -- use 'againxx/vim-textobj-underscore'
  use 'Julian/vim-textobj-variable-segment'

  ---
  --- QuickFix
  ---
  use {
    'stevearc/qf_helper.nvim',
    config = function() require('qf_helper').setup() end
  }
  use {
    'tpope/vim-scriptease',
    cmd = { 'PP', 'Scriptnames', 'Messages', 'Verbose' }
  }

  ---
  --- ROS
  ---
  -- if os.getenv('ROS_ROOT') then
  --   use {
  --     'taketwo/vim-ros',
  --     cond = function() return not os.getenv('CONDA_PREFIX') end
  --   }
  -- end

  ---
  --- Utility
  ---
  use 'tpope/vim-abolish'
  use 'tpope/vim-capslock'
  use 'AndrewRadev/switch.vim'
  use 'Konfekt/FastFold'
  use {
    'mbbill/undotree', cmd = 'UndotreeToggle',
    config = function() require('xx.undotree') end
  }
  use 'lambdalisue/suda.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use { 'rlue/vim-barbaric', ft = {'markdown', 'vimwiki'} }
  use { 'szw/vim-maximizer', cmd = 'MaximizerToggle' }
  use 'jeffkreeftmeijer/vim-numbertoggle'
  -- embed neovim in browser input box
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  ---
  --- Training Vim
  ---
  use { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' }

end,
config = {
  profile = {
    enable = false,
  }
}})
