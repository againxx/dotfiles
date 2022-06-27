vim.env.ZDOTDIR = vim.env.HOME .. "/.config/zsh-st"
-- Rainbow
vim.g.rainbow_active = true -- set to 0 if you want to enable it later via :RainbowToggle
-- Disable it for CMake files, since it breaks cmake syntax highlighting
vim.g.rainbow_conf = {
  separately = {
    cmake = 0,
    vimwiki = 0,
    fzf = 0,
    cpp = 0,
  },
}

-- indent_blankline
vim.g.indent_blankline_char = "│" -- │┃
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_filetype_exclude = { "help", "man", "dashboard", "dapui_hover" }
vim.g.indent_blankline_show_current_context = false

-- Vim-slime
vim.g.slime_target = "tmux"
vim.g.slime_paste_file = "$HOME/.local/share/nvim/.slime_paste"
vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
vim.g.slime_python_ipython = 1

-- tmuxline
vim.g.tmuxline_preset = "nightly_fox"

-- Python-syntax
vim.g.python_syntax_space_errors = false

-- Matchup
vim.g.matchup_matchparen_nomode = "i"
vim.g.matchup_matchparen_enabled = true
vim.g.matchup_mappings_enabled = false

-- Vim-tmux-navigator
-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = true
vim.g.tmux_navigator_no_mappings = true

-- Vim-be-good
vim.g.vim_be_good_floating = false

-- Barbaric
-- The IME to invoke for managing input languages (macos, fcitx, ibus, xkb-switch)
vim.g.barbaric_ime = "fcitx"
vim.g.barbaric_fcitx_cmd = "fcitx5-remote"
-- The input method for Normal mode (as defined by `xkbswitch -g`, `ibus engine`, or `xkb-switch -p`)
vim.g.barbaric_default = "-c"

-- vim-maximizer
vim.g.maximizer_set_default_mapping = false

-- jupytext
vim.g.jupytext_fmt = "py:percent"

-- FastFold
vim.g.fastfold_minlines = 0
vim.g.fastfold_savehook = false
vim.g.fastfold_fold_movement_commands = { "]z", "[z" }

-- vim-translator
vim.g.translator_default_engines = { "haici" }

-- Firenvim settings
vim.g.firenvim_config = {
  localSettings = {
    ["https?://[^/]+\\.notion\\.so/"] = {
      takeover = "never",
      priority = 1,
    },
    ["https?://tam.cmet.ustc.edu.cn/"] = {
      takeover = "never",
      priority = 1,
    },
    ["localhost:[0-9]+/lab"] = {
      takeover = "never",
      priority = 1,
    },
  },
}

-- vim-illuminate
vim.g.Illuminate_ftblacklist = { "defx", "NeogitStatus", "NeogitCommitMessage", "qf" }

-- nvim-hlslens
require("hlslens").setup {
  calm_down = true,
  override_lens = function(render, pos_list, nearest, idx, rel_idx)
    local sfw = vim.v.searchforward == 1
    local indicator, text, chunks
    local abs_rel_idx = math.abs(rel_idx)
    if abs_rel_idx > 1 then
      indicator = ("%d%s"):format(abs_rel_idx, sfw ~= (rel_idx > 1) and "▲" or "▼")
    elseif abs_rel_idx == 1 then
      indicator = sfw ~= (rel_idx == 1) and "▲" or "▼"
    else
      indicator = ""
    end

    local lnum, col = unpack(pos_list[idx])
    if nearest then
      local cnt = #pos_list
      if indicator ~= "" then
        text = ("[%s %d/%d]"):format(indicator, idx, cnt)
      else
        text = ("[%d/%d]"):format(idx, cnt)
      end
      chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
    else
      text = ("[%s %d]"):format(indicator, idx)
      chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  end,
}
