require('neoscroll').setup({
  mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
  easing_function = 'sine'
})

local keymap = vim.keymap

-- Scroll floating window up and down
keymap.set('n', '<C-f>',
  "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
keymap.set('n', '<C-b>',
  "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
keymap.set('v', '<C-f>',
  "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
keymap.set('v', '<C-b>',
  "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
keymap.set('n', '<C-y>', "<cmd>lua require('neoscroll').scroll(-3, false, 80, nil)<cr>",
  { silent = true, nowait = true, noremap = true })
keymap.set('n', '<C-e>', "<cmd>lua require('neoscroll').scroll(3, false, 80, nil)<cr>",
  { silent = true, nowait = true, noremap = true })

-- lightspeed 'cold' repeat
keymap.set('n', ';', "<Plug>Lightspeed_;_ft",
  { silent = true, nowait = true, noremap = false })
keymap.set('n', ',', "<Plug>Lightspeed_,_ft",
  { silent = true, nowait = true, noremap = false })
