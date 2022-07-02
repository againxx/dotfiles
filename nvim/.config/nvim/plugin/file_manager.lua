vim.g.neo_tree_remove_legacy_commands = 1
vim.g.neotree_explorer_presets = {
  vimrc = {
    "~/.config/nvim",
  },
  dotfiles = {
    "~/dotfiles",
  },
  dictionaries = {
    "~/dotfiles/vim/cSpell_dictionaries/",
  },
  tmuxp = {
    "~/.config/tmuxp/",
  },
}

local open_neotree = function(preset)
  require("bufferline.state").set_offset(40, "")
  if preset then
    local preset_config = vim.g.neotree_explorer_presets[preset]
    if preset_config then
      vim.cmd("Neotree toggle " .. table.concat(preset_config, " "))
    else
      vim.cmd("Neotree toggle " .. preset)
    end
  else
    vim.cmd "Neotree toggle"
  end
end

local diagnostic_symbols = {
  Error = "理",
  Warn = "",
  Info = "",
  Hint = "",
}

require("neo-tree").setup {
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
    },
  },
  window = {
    mappings = {
      ["h"] = function(state)
        local node = state.tree:get_node()
        if state.current_position == "current" then
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          state.commands["navigate_up"](state)
        else
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end
      end,
      ["l"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          if state.current_position == "current" then
            state.commands["set_root"](state)
          else
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        else
          state.commands["open"](state)
        end
      end,
      ["a"] = function(state)
        local node = state.tree:get_node()
        if state.current_position == "current" and not node:is_expanded() and node:has_children() then
          local fs_actions = require("neo-tree.sources.filesystem.lib.fs_actions")
          local parent_id = node:get_parent_id()
          fs_actions.create_node(parent_id, nil, parent_id)
        else
          state.commands["add"](state)
        end
      end,
      ["d"] = "none",
      ["df"] = "delete",
      ["dd"] = "cut_to_clipboard",
      ["s"] = "none",
      ["S"] = "none",
      ["c"] = "none",
      ["cw"] = "rename",
      ["y"] = "none",
      ["yy"] = "copy",
      ["yc"] = "copy_to_clipboard",
      ["<c-v>"] = "open_vsplit",
      ["<c-x>"] = "open_split",
    },
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    bind_to_cwd = false, -- do not change vim's cwd to neo-tree's root
    window = {
      mappings = {
        ["<C-h>"] = "toggle_hidden",
        ["zh"] = "toggle_hidden",
        ["<C-c>"] = "clear_filter",
        ["[c"] = "prev_git_modified",
        ["]c"] = "next_git_modified",
        ["o"] = "system_open",
        ["cd"] = "change_cwd",
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node.path
        vim.cmd("silent !xdg-open " .. path)
      end,
      change_cwd = function(state)
        local parent_id = state.tree:get_node():get_parent_id()
        local parent = state.tree:get_node(parent_id)
        local saved_path = state.path
        state.path = parent.path
        require("neo-tree.sources.manager").set_cwd(state)
        vim.notify("Change CWD to " .. state.path)
        state.path = saved_path
      end
    },
    components = {
      diagnostics = function(config, node, state)
        local diag = state.diagnostics_lookup or {}
        local diag_state = diag[node:get_id()]
        if not diag_state then
          return {}
        end
        if config.errors_only and diag_state.severity_number > 1 then
          return {}
        end
        local severity = diag_state.severity_string
        local defined = vim.fn.sign_getdefined("DiagnosticSign" .. severity)
        defined = defined and defined[1]
        defined.text = diagnostic_symbols[severity]
        if defined and defined.text and defined.texthl then
          -- for some reason it always comes padded with a space
          if type(defined.text) == "string" and defined.text:sub(#defined.text) == " " then
            defined.text = defined.text:sub(1, -2)
          end
          return {
            text = " " .. defined.text,
            highlight = defined.texthl,
          }
        else
          return {
            text = " " .. severity:sub(1, 1),
            highlight = "Diagnostic" .. severity,
          }
        end
      end
    }
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.o.guicursor = "n:NeotreeCursorHiddenCursor"
        vim.cmd [[hi CursorLine guibg=#4c6482 gui=bold]]
      end,
    },
    {
      event = "neo_tree_buffer_leave",
      handler = function()
        vim.o.guicursor = _G.NeotreeSavedCursor
        vim.cmd [[hi CursorLine guibg=#191e2a guifg=NONE gui=NONE]]
      end,
    },
    {
      event = "neo_tree_popup_buffer_enter",
      handler = function()
        vim.keymap.set('i', '<c-j>', '<down>', { buffer = 0, remap = true, silent = true})
        vim.keymap.set('i', '<c-k>', '<up>', { buffer = 0, remap = true, silent = true})
        vim.cmd [[hi CursorLine guibg=#4c6482 gui=bold]]
      end
    }
  },
}

require("window-picker").setup {
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

      -- if the buffer type is one of following, the window will be ignored
      buftype = { "terminal" },
    },
  },
  other_win_hl_color = "#F27983",
}

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register({
  e = {
    name = "+edit/explorer",
    r = { "<cmd>AsyncTaskEdit<cr>", "Edit local tasks" },
    R = { "<cmd>AsyncTaskEdit!<cr>", "Edit global tasks" },
    t = { "<cmd>lua require('xx.telescope').edit_tmuxp()<cr>", "Edit tmuxp configs" },
    T = {
      function()
        open_neotree "tmuxp"
      end,
      "Explore tmuxp config folder",
    },
    c = {
      function()
        open_neotree "%:p:h"
      end,
      "Explore current folder",
    },
    m = {
      ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>",
      "Edit macro / register",
    },
    e = {
      function()
        if vim.b.gitsigns_status_dict then
          open_neotree(vim.b.gitsigns_status_dict.root)
        else
          open_neotree()
        end
      end,
      "Explore current git repo",
    },
    p = { "<cmd>lua require('xx.telescope').edit_vim_plugins()<cr>", "Edit nvim plugin files" },
    v = { "<cmd>lua require('xx.telescope').edit_vimrc()<cr>", "Edit nvim config" },
    V = {
      function()
        open_neotree "vimrc"
      end,
      "Explore nvim config folder",
    },
    d = { "<cmd>lua require('xx.telescope').edit_dotfiles()<cr>", "Edit dotfiles" },
    D = {
      function()
        open_neotree "dotfiles"
      end,
      "Explore dotfile folder",
    },
    w = { "<cmd>lua require('xx.telescope').edit_dictionaries()<cr>", "Edit cSpell dictionaries" },
    W = {
      function()
        open_neotree "dictionaries"
      end,
      "Explore cSpell dictionary folder",
    },
    h = { "<cmd>edit %:h<cr>", "Edit current file's directory" },
  },
  lf = { "<cmd>Lf<cr>", "Lf" },
}, {
  prefix = "<leader>",
})

-- rnvimr
-- Make Ranger replace netrw and be the file explorer
-- vim.g.rnvimr_enable_ex = false
-- vim.g.rnvimr_layout = {
--   relative = "editor",
--   width = math.ceil(0.8 * vim.o.columns),
--   height = math.ceil(0.8 * vim.o.lines),
--   col = math.floor(0.1 * vim.o.columns),
--   row = math.floor(0.1 * vim.o.lines),
--   style = "minimal",
-- }
