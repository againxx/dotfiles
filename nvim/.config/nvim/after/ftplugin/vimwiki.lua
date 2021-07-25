vim.api.nvim_buf_del_keymap(0, 'n', '<leader>wd')
vim.api.nvim_buf_del_keymap(0, 'n', '<tab>')
vim.api.nvim_buf_del_keymap(0, 'n', '<s-tab>')
-- unmap automatic list adding
vim.api.nvim_buf_del_keymap(0, 'n', 'o')
vim.api.nvim_buf_del_keymap(0, 'n', 'O')
