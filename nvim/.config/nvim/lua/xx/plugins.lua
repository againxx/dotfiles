return {
  ---
  --- LSP & Autocompletion
  ---
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-omni",
  "octaltree/cmp-look",
  "rcarriga/cmp-dap",
  "againxx/cmp-katex",
  "andersevenrud/cmp-tmux",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  "onsails/lspkind-nvim",
  "ray-x/lsp_signature.nvim",
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
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
  },
  "j-hui/fidget.nvim", -- UI for lsp progress
  {
    "filipdutescu/renamer.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
  },

  ---
  --- Debugger
  ---
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  "theHamsta/nvim-dap-virtual-text",
  "jbyuki/one-small-step-for-vimkind",

  ---
  --- Test
  ---
  "janko/vim-test",

  ---
  --- Git
  ---
  { "TimUntersberger/neogit", dependencies = "nvim-lua/plenary.nvim" },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "lewis6991/gitsigns.nvim",
  "samoshkin/vim-mergetool",
  -- use { "kdheepak/lazygit.nvim", cmd = "LazyGit" }

  ---
  --- Filesystem
  ---
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      { "s1n7ax/nvim-window-picker", version = "2.*" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  -- use "kevinhwang91/rnvimr"
  {
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
  },

  ---
  --- Colorscheme & Icons
  ---
  "tjdevries/colorbuddy.nvim",
  "againxx/ayu-vim",
  "folke/tokyonight.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
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
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  ---
  --- Statusline & Notification
  ---
  "nvim-lualine/lualine.nvim",
  {
    "romgrk/barbar.nvim",
    init = function() vim.g.barbar_auto_setup = false end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#1F2430",
      }
      vim.notify = require "notify"
    end,
  },

  ---
  --- Start Screen & Session
  ---
  { "nvimdev/dashboard-nvim", event = "VimEnter" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/sessions/"),
      }
    end,
  },

  ---
  --- Window & Buffer & Keybindings
  ---
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { rules = false },
    },
  },

  ---
  --- Fuzzy Finder
  ---
  {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-fzf-writer.nvim",
  "GustavoKatel/telescope-asynctasks.nvim",
  "benfowler/telescope-luasnip.nvim",
  "nvim-telescope/telescope-z.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "againxx/telescope-ros.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-frecency.nvim",

  ---
  --- Highlighting
  ---
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "hiphish/rainbow-delimiters.nvim",
  "pboettch/vim-cmake-syntax",
  "vim-scripts/SyntaxAttr.vim",
  "againxx/python-syntax",
  "againxx/vim-valgrind",
  "aklt/plantuml-syntax",
  "norcalli/nvim-terminal.lua", -- highlight terminal escape sequences
  "kevinoid/vim-jsonc",
  "RRethy/vim-illuminate", -- highlight other use of the current word

  ---
  --- Search & Move
  ---
  "kevinhwang91/nvim-hlslens",
  {
    "ggandor/lightspeed.nvim",
    config = function()
      require("lightspeed").setup {
        safe_labels = { "f", "n", "u", "t", "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z", "Q" },
        -- f/t
        -- instant_repeat_fwd_key = ';',
        -- instant_repeat_bwd_key = ',',
      }
    end,
  },
  "karb94/neoscroll.nvim", -- smooth scrolling
  "windwp/nvim-spectre", -- global search panel supporting regex

  ---
  --- Comment & Surround & Parenthsis
  ---
  "tpope/vim-surround",
  "tpope/vim-repeat", -- repeat plugin map with '.', work with vim-surround
  -- use 'tpope/vim-commentary'
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
  },
  "andymass/vim-matchup",

  ---
  --- Snippets
  ---
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  "againxx/vim-snippets",

  ---
  --- Python
  ---
  "michaeljsmith/vim-indent-object",
  "Vimjas/vim-python-pep8-indent",
  "goerz/jupytext.vim",

  ---
  --- Cpp
  ---
  "skywind3000/vim-cppman",
  "p00f/clangd_extensions.nvim",

  ---
  --- Rust
  ---
  "simrat39/rust-tools.nvim",
  { -- managing crates.io dependencies
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  ---
  --- OpenGL
  ---
  "tikhomirov/vim-glsl", -- syntax highlighting for glsl

  ---
  --- Assembly
  ---
  "Shirk/vim-gas",

  ---
  --- Markdown
  ---
  -- this plugin is needed by vim-markdown and can be used to align text
  { "godlygeek/tabular", ft = "markdown" },
  "preservim/vim-markdown",
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  }, -- use pre build
  {
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle", "TableModeEnable" },
  },

  ---
  --- Latex
  ---
  { "lervag/vimtex", ft = { "tex", "markdown" } },

  ---
  --- Note taking
  ---
  { "againxx/vimwiki-1", branch = "dev", ft = "vimwiki" },
  -- "tools-life/taskwiki",
  {
    "michal-h21/vim-zettel",
    ft = "vimwiki",
    dependencies = {
      { "junegunn/fzf", ft = { "vimwiki", "qf" } },
      { "junegunn/fzf.vim", ft = "vimwiki" },
    },
    config = function()
      require "xx.fzf"
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              wiki = "~/Documents/Vimwiki/neorg",
            },
          },
        },
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.integrations.telescope"] = {},
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              keybinds.remap_key("norg", "n", "<M-j>", "<M-d>")
              keybinds.remap_key("norg", "n", "<M-k>", "<M-u>")
            end,
          },
        },
      },
    },
    build = ":Neorg sync-parsers",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-neorg/neorg-telescope" },
    },
  },
  "jbyuki/nabla.nvim", -- visualize latex as ascii symbols
  {
    "askfiy/nvim-picgo",
    cmd = { "UploadClipboard", "UploadImagefile" },
    config = function()
      require("nvim-picgo").setup {
        image_name = true,
      }
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cmd = { "ObsidianNew", "ObsidianNewFromTemplate", "ObsidianTags", "ObsidianOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/Documents/Obsidian-Notes",
        },
      },
      log_level = vim.log.levels.WARN,
      daily_notes = {
        folder = "6-Dailies",
      },
      new_notes_location = "current_dir",
      note_id_func = function(title)
        local prefix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name and only keep the first four words if the name is too long.
          prefix = title:gsub("[^A-Za-z0-9- ]", ""):lower()
          local words = vim.split(prefix, " ", { trimempty = true })
          local first_four_words = {}
          for i = 1, math.min(4, #words) do
            table.insert(first_four_words, words[i])
          end
          prefix = vim.iter(first_four_words):join "_"
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            prefix = prefix .. string.char(math.random(65, 90))
          end
        end
        -- Get the current date and time
        local current_date = os.date "*t"

        -- Extract the year, month, and day
        local year = current_date.year % 100 -- Get last two digits of the year
        local month = current_date.month
        local day = current_date.day

        -- Format the year, month, and day to ensure two digits each
        local formatted_date = string.format("%02d%02d%02d", year, month, day)

        return prefix .. "-" .. formatted_date
      end,
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        if out.date == nil then
          -- add date property to the frontmatter as well
          out.date = os.date "%Y-%m-%d %H:%M"
        end

        return out
      end,
    },
  },

  ---
  --- Task system
  ---
  "skywind3000/asynctasks.vim",
  "skywind3000/asyncrun.vim",

  ---
  --- Tmux Integration
  ---
  {
    "edkolev/tmuxline.vim",
    cmd = { "Tmuxline", "TmuxlineSnapshot" },
  },
  "christoomey/vim-tmux-navigator",
  "jpalardy/vim-slime",
  "wellle/tmux-complete.vim",

  ---
  --- Curosr & Alignment
  ---
  "mg979/vim-visual-multi",
  "junegunn/vim-easy-align",

  ---
  --- Documentation
  ---
  -- Read Unix man pages in vim
  "jez/vim-superman",
  "HiPhish/info.vim",

  ---
  --- Custom Text Objects
  ---
  -- use 'againxx/vim-textobj-underscore'
  {
    "Julian/vim-textobj-variable-segment",
    dependencies = "kana/vim-textobj-user",
  },
  "wellle/targets.vim",

  ---
  --- QuickFix
  ---
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup {
        preview = {
          -- nvim core now has problems related to winblend which turn the background into black, so disable it for now.
          winblend = 0,
        },
      }
    end,
  },
  {
    "stevearc/qf_helper.nvim",
    config = function()
      require("qf_helper").setup {
        quickfix = {
          -- use mappings from nvim-bqf
          default_bindings = false,
        },
      }
    end,
  },
  {
    "tpope/vim-scriptease",
    cmd = { "PP", "Scriptnames", "Messages", "Verbose" },
  },

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
  "tpope/vim-abolish",
  "tpope/vim-capslock",
  "tpope/vim-sleuth", -- automatically adjust indentation options
  "AndrewRadev/switch.vim",
  "Konfekt/FastFold",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      require "xx.undotree"
    end,
  },
  { "lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead" } },
  "tpope/vim-eunuch", -- Delete, Move, Mkdir, Rename, Chmod, etc.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup {
        exclude = {
          filetypes = { "dashboard" },
        },
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    end,
  },
  { "rlue/vim-barbaric", ft = { "markdown", "vimwiki", "tex" } },
  { "szw/vim-maximizer", cmd = "MaximizerToggle" },
  "jeffkreeftmeijer/vim-numbertoggle",
  -- embed neovim in browser input box
  -- {
  --   "glacambre/firenvim",
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- },
  "voldikss/vim-translator",
  "chentoast/marks.nvim",
  "ThePrimeagen/harpoon",
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "tami5/sqlite.lua",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    -- use a forked version before this PR is merged
    -- https://github.com/anuvyklack/pretty-fold.nvim/pull/41
    "bbjornstad/pretty-fold.nvim",
    -- requires = "anuvyklack/nvim-keymap-amend", -- only for preview
    config = function()
      require("pretty-fold").setup {
        fill_char = "·",
      }
      -- require("pretty-fold.preview").setup {
      --   border = 'shadow',
      -- }
    end,
  },
  { -- peek the buffer while entering line number
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  ---
  --- Training Vim
  ---
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

  ---
  --- Docs
  ---
  "milisims/nvim-luaref", -- add help reference for lua
  "nanotee/luv-vimdocs", -- add help reference for luv

  ---
  --- Local plugins
  ---
  {
    dir = "~/.config/nvim/locals/jieba-ci",
    build = "cargo build --release",
  },
  {
    dir = "~/.config/nvim/locals/cmp-zi",
    build = "cargo build --release",
  },
}
