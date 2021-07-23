if not pcall(require, 'nvim-treesitter.configs') then
  return
end

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
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>rj"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>rk"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
        [']h'] = '@include'
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
        ['[h'] = '@include'
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  ['[f'] = 'Previous function start',
  ['[F'] = 'Previous function end',
  [']f'] = 'Next function start',
  [']F'] = 'Next function end',
  ['[['] = 'Previous class start',
  ['[]'] = 'Previous class end',
  [']]'] = 'Next class start',
  [']['] = 'Next class end',
  ['<leader>rj'] = 'Swap with next parameter',
  ['<leader>rk'] = 'Swap with previous parameter'
})
