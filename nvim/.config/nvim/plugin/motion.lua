require('neoscroll').setup({
  mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
  easing_function = 'sine'
})

local api = vim.api

-- Scroll floating window up and down
api.nvim_set_keymap('n', '<C-f>',
  "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
api.nvim_set_keymap('n', '<C-b>',
  "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
api.nvim_set_keymap('i', '<C-f>',
  [[coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]],
  { silent = true, nowait = true, expr = true, noremap = true })
api.nvim_set_keymap('i', '<C-b>',
  [[coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]],
  { silent = true, nowait = true, expr = true, noremap = true })
api.nvim_set_keymap('v', '<C-f>',
  "<cmd>lua require('xx.neoscroll')(vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
api.nvim_set_keymap('v', '<C-b>',
  "<cmd>lua require('xx.neoscroll')(-vim.api.nvim_win_get_height(0), true, 500)<cr>",
  { silent = true, nowait = true, noremap = true })
api.nvim_set_keymap('n', '<C-y>', "<cmd>lua require('neoscroll').scroll(-3, false, 80, nil)<cr>",
  { silent = true, nowait = true, noremap = true })
api.nvim_set_keymap('n', '<C-e>', "<cmd>lua require('neoscroll').scroll(3, false, 80, nil)<cr>",
  { silent = true, nowait = true, noremap = true })

-- Sneak
vim.g['sneak#f_reset'] = false
vim.g['sneak#t_reset'] = false
vim.g['sneak#prompt'] = '省'
-- immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
-- vim.g['sneak#s_next'] = 1

-- Quick-scope
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_lazy_highlight = true
