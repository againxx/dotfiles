vim.cmd [[packadd packer.nvim]]

if vim.fn.has "mac" then
  require("packer").init {
    max_jobs = 60,
  }
end

return require("packer").startup {
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    ---
    --- LSP & Autocompletion
    ---
    use {
      "williamboman/nvim-lsp-installer",
      config = function()
        require("nvim-lsp-installer").setup {}
      end,
    }
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-omni"
    use "octaltree/cmp-look"
    use "rcarriga/cmp-dap"
    use "againxx/cmp-katex"
    use "andersevenrud/cmp-tmux"
    use "hrsh7th/nvim-cmp"
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind-nvim"
    use "ray-x/lsp_signature.nvim"
    use { "againxx/lspsaga.nvim", branch = "fix/hover_markdown_escape" }
    use {
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
      config = function()
        require("symbols-outline").setup {
          width = 35,
          auto_preview = false,
          preview_bg_highlight = "NormalFloat",
          keymaps = { -- These keymaps can be a string or a table for multiple keys
            toggle_preview = "p",
          },
        }
      end,
    }
    use "j-hui/fidget.nvim" -- UI for lsp progress
    use {
      "filipdutescu/renamer.nvim",
      branch = "master",
      requires = { { "nvim-lua/plenary.nvim" } },
    }

    ---
    --- Debugger
    ---
    use "mfussenegger/nvim-dap"
    use "mfussenegger/nvim-dap-python"
    use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" }
    use { "theHamsta/nvim-dap-virtual-text", module = "xx.dap" }
    use "jbyuki/one-small-step-for-vimkind"

    ---
    --- Test
    ---
    use "janko/vim-test"

    ---
    --- Git
    ---
    -- use 'tpope/vim-fugitive'
    use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
    use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
    use "lewis6991/gitsigns.nvim"
    use "samoshkin/vim-mergetool"
    -- use { "kdheepak/lazygit.nvim", cmd = "LazyGit" }

    ---
    --- Filesystem
    ---
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
          "s1n7ax/nvim-window-picker",
          tag = "1.*",
        },
      },
    }
    -- use "kevinhwang91/rnvimr"
    use {
      "is0n/fm-nvim",
      cmd = { "Lazygit", "Lf" },
      config = function()
        require("fm-nvim").setup {
          ui = {
            float = {
              border = "rounded",
              border_hl = "TelescopeBorder",
              height = 0.9,
              width = 0.9,
            },
          },
        }
      end,
    }

    ---
    --- Colorscheme & Icons
    ---
    use "tjdevries/colorbuddy.nvim"
    use "againxx/ayu-vim"
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup {
          override = {
            wiki = {
              icon = "",
              color = "#F07178",
              name = "Vimwiki",
            },
            norg = {
              icon = "",
              color = "#B695E0",
              name = "Norg",
            },
            pyi = {
              icon = "",
              color = "#77A8D9",
              name = "Pyi",
            },
            cu = {
              icon = "",
              color = "#854CC7",
              name = "Cuda",
            },
          },
          default = true,
        }
      end,
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    }

    ---
    --- Statusline & Notification
    ---
    use "hoob3rt/lualine.nvim"
    use "romgrk/barbar.nvim"
    use {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup {
          background_colour = "#1F2430",
        }
        vim.notify = require "notify"
      end,
    }
    use {
      "SmiteshP/nvim-gps", -- statusline component that shows current scope
      requires = "nvim-treesitter/nvim-treesitter",
    }

    ---
    --- Start Screen & Session
    ---
    use "glepnir/dashboard-nvim"
    use {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      module = "persistence",
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/sessions/"),
        }
      end,
    }

    ---
    --- Window & Buffer & Keybindings
    ---
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end,
    }

    ---
    --- Fuzzy Finder
    ---
    use {
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "GustavoKatel/telescope-asynctasks.nvim"
    use {
      "benfowler/telescope-luasnip.nvim",
      module = "telescope._extensions.luasnip",
    }
    use {
      "nvim-telescope/telescope-z.nvim",
      module = "telescope._extensions.z",
    }
    use {
      "nvim-telescope/telescope-file-browser.nvim",
      module = "telescope._extensions.file_browser",
    }
    use {
      "againxx/telescope-ros.nvim",
      module = "telescope._extensions.ros",
    }
    use "nvim-telescope/telescope-ui-select.nvim"
    use {
      "nvim-telescope/telescope-frecency.nvim",
      requires = "tami5/sqlite.lua",
    }

    ---
    --- Highlighting
    ---
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "p00f/nvim-ts-rainbow"
    use "pboettch/vim-cmake-syntax"
    use "vim-scripts/SyntaxAttr.vim"
    use "againxx/python-syntax"
    use "againxx/vim-valgrind"
    use "aklt/plantuml-syntax"
    use "norcalli/nvim-terminal.lua" -- highlight terminal escape sequences
    use "kevinoid/vim-jsonc"
    use "RRethy/vim-illuminate" -- highlight other use of the current word

    ---
    --- Search & Move
    ---
    use "kevinhwang91/nvim-hlslens"
    use {
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup {
          safe_labels = { "f", "n", "u", "t", "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z", "Q" },
          -- f/t
          -- instant_repeat_fwd_key = ';',
          -- instant_repeat_bwd_key = ',',
        }
      end,
    }
    use "karb94/neoscroll.nvim" -- smooth scrolling
    use "windwp/nvim-spectre" -- global search panel supporting regex

    ---
    --- Comment & Surround & Parenthsis
    ---
    use "tpope/vim-surround"
    use "tpope/vim-repeat" -- repeat plugin map with '.', work with vim-surround
    -- use 'tpope/vim-commentary'
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {}
      end,
    }
    use "luochen1990/rainbow"
    use "andymass/vim-matchup"

    ---
    --- Snippets
    ---
    use "L3MON4D3/LuaSnip"
    use "againxx/vim-snippets"

    ---
    --- Python
    ---
    use "michaeljsmith/vim-indent-object"
    use "Vimjas/vim-python-pep8-indent"
    use "goerz/jupytext.vim"

    ---
    --- Cpp
    ---
    use "skywind3000/vim-cppman"
    use "p00f/clangd_extensions.nvim"

    ---
    --- Rust
    ---
    use "simrat39/rust-tools.nvim"
    use { -- managing crates.io dependencies
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("crates").setup()
      end,
    }

    ---
    --- OpenGL
    ---
    use "tikhomirov/vim-glsl" -- syntax highlighting for glsl

    ---
    --- Assembly
    ---
    use "Shirk/vim-gas"

    ---
    --- Markdown
    ---
    -- this plugin is needed by vim-markdown and can be used to align text
    use { "godlygeek/tabular", ft = "markdown" }
    use "plasticboy/vim-markdown"
    use {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    } -- use pre build
    use {
      "dhruvasagar/vim-table-mode",
      cmd = { "TableModeToggle", "TableModeEnable" },
    }

    ---
    --- Latex
    ---
    use { "lervag/vimtex", ft = { "tex", "markdown" } }

    ---
    --- Note taking
    ---
    use { "againxx/vimwiki-1", branch = "dev" }
    use "tools-life/taskwiki"
    use {
      "michal-h21/vim-zettel",
      ft = "vimwiki",
      requires = {
        { "junegunn/fzf", ft = { "vimwiki", "qf" } },
        { "junegunn/fzf.vim", ft = "vimwiki" },
      },
      config = function()
        require "xx.fzf"
      end,
    }
    use {
      "nvim-neorg/neorg",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.norg.dirman"] = {
              config = {
                workspaces = {
                  wiki = "~/Documents/Vimwiki/neorg",
                },
              },
            },
            ["core.norg.concealer"] = {
              config = {
                icon_preset = "varied",
              },
            },
            ["core.norg.completion"] = {
              config = {
                engine = "nvim-cmp",
              },
            },
            ["core.integrations.telescope"] = {},
            ["core.norg.manoeuvre"] = {},
            ["core.keybinds"] = {
              config = {
                hook = function(keybinds)
                  keybinds.remap_key("norg", "n", "<M-j>", "<M-d>")
                  keybinds.remap_key("norg", "n", "<M-k>", "<M-u>")
                end,
              },
            },
          },
        }
      end,
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-neorg/neorg-telescope" },
      },
    }
    use "jbyuki/nabla.nvim" -- visualize latex as ascii symbols
    use {
      "askfiy/nvim-picgo",
      cmd = { "UploadClipboard", "UploadImagefile" },
      config = function()
        require("nvim-picgo").setup {}
      end,
    }

    ---
    --- Task system
    ---
    use "skywind3000/asynctasks.vim"
    use "skywind3000/asyncrun.vim"

    ---
    --- Tmux Integration
    ---
    use {
      "edkolev/tmuxline.vim",
      cmd = { "Tmuxline", "TmuxlineSnapshot" },
    }
    use "christoomey/vim-tmux-navigator"
    use "jpalardy/vim-slime"
    use "wellle/tmux-complete.vim"

    ---
    --- Curosr & Alignment
    ---
    use "mg979/vim-visual-multi"
    use "junegunn/vim-easy-align"

    ---
    --- Documentation
    ---
    -- Read Unix man pages in vim
    use "jez/vim-superman"
    use "HiPhish/info.vim"

    ---
    --- Custom Text Objects
    ---
    use "kana/vim-textobj-user"
    -- use 'againxx/vim-textobj-underscore'
    use "Julian/vim-textobj-variable-segment"
    use "wellle/targets.vim"

    ---
    --- QuickFix
    ---
    use { "kevinhwang91/nvim-bqf", ft = "qf" }
    use {
      "stevearc/qf_helper.nvim",
      config = function()
        require("qf_helper").setup {
          quickfix = {
            -- use mappings from nvim-bqf
            default_bindings = false,
          },
        }
      end,
    }
    use {
      "tpope/vim-scriptease",
      cmd = { "PP", "Scriptnames", "Messages", "Verbose" },
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
    use "tpope/vim-abolish"
    use "tpope/vim-capslock"
    use "tpope/vim-sleuth" -- automatically adjust indentation options
    use "AndrewRadev/switch.vim"
    use "Konfekt/FastFold"
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    }
    use {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      config = function()
        require "xx.undotree"
      end,
    }
    use { "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } }
    use "tpope/vim-eunuch" -- Delete, Move, Mkdir, Rename, Chmod, etc.
    use "lukas-reineke/indent-blankline.nvim"
    use { "rlue/vim-barbaric", ft = { "markdown", "vimwiki", "tex" } }
    use { "szw/vim-maximizer", cmd = "MaximizerToggle" }
    use "jeffkreeftmeijer/vim-numbertoggle"
    -- embed neovim in browser input box
    -- use {
    --   "glacambre/firenvim",
    --   run = function()
    --     vim.fn["firenvim#install"](0)
    --   end,
    -- }
    use "voldikss/vim-translator"
    use "chentoast/marks.nvim"
    use "ThePrimeagen/harpoon"
    use {
      "AckslD/nvim-neoclip.lua",
      module = "neoclip",
      requires = {
        { "tami5/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
      },
    }
    use "lewis6991/impatient.nvim" -- speed up startup time
    use {
      "anuvyklack/pretty-fold.nvim",
      -- requires = "anuvyklack/nvim-keymap-amend", -- only for preview
      config = function()
        require("pretty-fold").setup {
          fill_char = "·",
        }
        -- require("pretty-fold.preview").setup {
        --   border = 'shadow',
        -- }
      end,
    }
    use {  -- peek the buffer while entering line number
      'nacro90/numb.nvim',
      config = function()
        require('numb').setup()
      end,
    }

    ---
    --- Training Vim
    ---
    use { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" }

    ---
    --- Docs
    ---
    use "milisims/nvim-luaref" -- add help reference for lua
    use "nanotee/luv-vimdocs" -- add help reference for luv

    ---
    --- Local plugins
    ---
    use {
      "~/.config/nvim/locals/jieba-ci",
      run = "cargo build --release",
    }
    use {
      "~/.config/nvim/locals/cmp-zi",
      run = "cargo build --release",
    }
  end,
  config = {
    profile = {
      enable = false,
    },
  },
}
