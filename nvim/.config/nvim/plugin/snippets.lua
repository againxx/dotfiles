-- vim.g.ulti_expand_res = 0
vim.g.luasnip_python_quoting_style = "double" -- double/single
vim.g.luasnip_python_style = "sphinx"
vim.g.luasnip_cpp_style = "google"

-- Use <C-l> to expand ultisnips or save visual selected content
-- vim.g.UltiSnipsExpandTrigger = '<C-l>'
-- vim.g.UltiSnipsJumpForwardTrigger = '<M-j>'
-- vim.g.UltiSnipsJumpBackwardTrigger = '<M-k>'
-- vim.g.UltiSnipsListSnippets = '<M-l>'

-- neovim bug that doesn't specify noautocmd: true for making floating window options
-- https://github.com/ray-x/lsp_signature.nvim/issues/143
-- local old_make_floating = vim.lsp.util.make_floating_popup_options
-- if not old_make_floating(0, 0, {}).noautocmd then
--     vim.lsp.util.make_floating_popup_options = function(width, height, opts)
--         local ret = old_make_floating(width, height, opts)
--         ret.noautocmd = true
--         return ret
--     end
-- end

local luasnip = require "luasnip"
local types = require "luasnip.util.types"

luasnip.config.setup {
  history = true,
  update_events = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  store_selection_keys = "<Tab>",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " choice node", "Todo" } },
      },
    },
  },
}

vim.keymap.set(
  { "i", "s" },
  "<M-j>",
  "<cmd>lua require'luasnip'.expand_or_jump()<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set({ "i", "s" }, "<M-k>", "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent = true, noremap = true })
vim.keymap.set(
  { "i", "s" },
  "<M-l>",
  "<cmd>lua require'luasnip'.change_choice(1)<cr>",
  { silent = true, noremap = true }
)

require("luasnip.loaders.from_lua").lazy_load { paths = "./lua/xx/snippets" }
vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>es", "<cmd>LuaSnipEdit<cr>", desc = "Edit snippets" },
  { "<leader>ls", "<cmd>lua require('xx.telescope').luasnip()<cr>", desc = "List available snippets" },
}
