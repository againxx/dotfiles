-- disable mapping for ge
vim.api.nvim_buf_del_keymap(0, "n", "ge")
vim.api.nvim_buf_del_keymap(0, "v", "ge")
