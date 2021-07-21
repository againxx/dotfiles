vim.opt.indentexpr = 'nvim_treesitter#indent()'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require('nvim-treesitter.configs').setup {
  ensure_installed = {'c', 'cpp', 'query', 'java', 'rust', 'python', 'lua'},
  highlight = {
    enable = true,
    disable = {'python'},
    custom_captures = {
      -- Highlight the error capture group with the "CocWarningSign" highlight group.
      ["error"] = "CocWarningSign",
    },
  },
  indent = {
    enable = true,
    disable = {'python'},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  rainbow = {
    enable = true,
    disabled = {
      "vim",
    },
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

-- Disable highlight for bracket
-- require('nvim-treesitter.highlight')
-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil
-- hlmap["punctuation.delimiter"] = "Delimiter"
-- hlmap["punctuation.bracket"] = nil
