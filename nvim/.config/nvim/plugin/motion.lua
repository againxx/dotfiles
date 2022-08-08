require("neoscroll").setup {
  mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
  easing_function = "sine",
}

local keymap = vim.keymap

local opts = { silent = true, nowait = true }
local plug_opts = { silent = true, nowait = true, remap = true }

-- Scroll floating window up and down
keymap.set("n", "<C-f>", "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>", opts)
keymap.set("n", "<C-b>", "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>", opts)
keymap.set("v", "<C-f>", "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>", opts)
keymap.set("v", "<C-b>", "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>", opts)
keymap.set("n", "<C-y>", "<cmd>lua require('neoscroll').scroll(-3, false, 80, nil)<cr>", opts)
keymap.set("n", "<C-e>", "<cmd>lua require('neoscroll').scroll(3, false, 80, nil)<cr>", opts)

-- lightspeed 'cold' repeat
keymap.set("n", ";", "<Plug>Lightspeed_;_ft", plug_opts)
keymap.set("n", ",", "<Plug>Lightspeed_,_ft", plug_opts)

require("marks").setup {
  mappings = {
    prev = '<M-">', -- pass false to disable only this default mapping
    next = "<M-'>",
  },
}

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", 'Add harpoon mark' },
  m = { "<cmd>lua require('xx.telescope').harpoon_marks()<cr>", 'View all harpoon marks' },
  j = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", 'Goto next harpoon mark' },
  k = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", 'Goto previous harpoon mark' },
}, { prefix = '<leader>m' })
