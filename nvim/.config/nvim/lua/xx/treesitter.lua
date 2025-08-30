if not pcall(require, "nvim-treesitter.configs") then
  return
end

vim.opt.indentexpr = "nvim_treesitter#indent()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "vim",
    "vimdoc",
    "query",
    "java",
    "json",
    "rust",
    "python",
    "lua",
    "cuda",
    "javascript",
    "starlark",
    "bash",
  },
  highlight = {
    enable = true,
    disable = { "markdown" },
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["i,"] = "@param.inner",
        ["a,"] = "@param.outer",
      },
    },
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
        ["]f"] = { query = "@function.name", desc = "Next function start" },
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]h"] = { query = "@include", desc = "Next include/import statement" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]["] = { query = "@class.outer", desc = "Next class end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.name", desc = "Previous function start" },
        ["[["] = { query = "@class.outer", desc = "Previous class start" },
        ["[h"] = { query = "@include", desc = "Previous include/import statement" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
      },
    },
  },
}

vim.api.nvim_set_hl(0, "@python.self", { link = "pythonTSSelf" })
vim.api.nvim_set_hl(0, "@python.docstring", { link = "pythonTSDocstring" })
vim.api.nvim_set_hl(0, "@lua.vim", { link = "Constructor" })

-- vim.treesitter.set_query(
--   "cpp",
--   "textobjects",
--   [=[
-- (function_definition
--   declarator: (function_declarator
--     declarator: [
--         (identifier) @function.name
--         (qualified_identifier
--             name: (identifier) @function.name)
-- ]))
-- ]=]
-- )

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add({
  { "<leader>rj", desc = "Swap with next parameter" },
  { "<leader>rk", desc = "Swap with previous parameter" },
})

wk.add({
  mode = { "x" },
  { "if", desc = "inner function" },
  { "af", desc = "a function (with signature)" },
  { "ic", desc = "inner class" },
  { "ac", desc = "a class (with class keyword)" },
  { "i,", desc = "inner parameter" },
  { "a,", desc = "a parameter with type" },
})

wk.add({
  mode = { "o" },
  { "if", desc = "inner function" },
  { "af", desc = "a function (with signature)" },
  { "ic", desc = "inner class" },
  { "ac", desc = "a class (with class keyword)" },
  { "i,", desc = "inner parameter" },
  { "a,", desc = "a parameter with type" },
})
