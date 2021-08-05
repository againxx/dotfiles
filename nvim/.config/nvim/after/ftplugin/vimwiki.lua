pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<leader>wd')
pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<tab>')
pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<s-tab>')
-- unmap automatic list adding
pcall(vim.api.nvim_buf_del_keymap, 0, 'n', 'o')
pcall(vim.api.nvim_buf_del_keymap, 0, 'n', 'O')
