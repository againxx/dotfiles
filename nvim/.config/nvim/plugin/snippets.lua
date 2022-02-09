vim.g.ulti_expand_res = 0
vim.g.ultisnips_python_quoting_style = "double"
vim.g.ultisnips_python_triple_quoting_style = "double"
vim.g.ultisnips_python_style = "sphinx"
vim.g.ultisnips_cpp_style = "google"

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

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  store_selection_keys = "<Tab>",
  enable_autosnippets = true,
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

function _G.snippets_clear()
  for m, _ in pairs(luasnip.snippets) do
    package.loaded["xx.snippets." .. m] = nil
  end
  luasnip.snippets = setmetatable({}, {
    __index = function(t, k)
      local ok, m = pcall(require, "xx.snippets." .. k)
      if not ok and not string.match(m, "^module.*not found:") then
        error(m)
      end
      t[k] = ok and m or {}
      return t[k]
    end,
  })
end

_G.snippets_clear()

vim.cmd [[
  augroup snippets_clear
    au!
    au BufWritePost ~/.config/nvim/lua/xx/snippets/*.lua lua _G.snippets_clear()
  augroup END
]]

function _G.edit_ft()
  local fts = require("luasnip.util.util").get_snippet_filetypes()
  vim.ui.select(fts, { prompt = "Select which filetype to edit:" }, function(item, idx)
    -- selection aborted -> idx == nil
    if idx then
      vim.cmd("edit ~/.config/nvim/lua/xx/snippets/" .. item .. ".lua")
    end
  end)
end

vim.cmd [[command! LuaSnipEdit :lua _G.edit_ft()]]

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register {
  ["<leader>ls"] = { "<cmd>lua require('xx.telescope').ultisnips()<cr>", "List available snippets" },
  ["<leader>es"] = { "<cmd>LuaSnipEdit<cr>", "Edit snippets" },
}
