local api = vim.api
local keymap = vim.keymap

-- common things
api.nvim_create_augroup("common", {})
-- Automatically relocate cursor position
api.nvim_create_autocmd("BufReadPost", {
  group = "common",
  callback = function()
    local previous_pos = vim.fn.line [['"]]
    if previous_pos >= 1 and previous_pos <= vim.fn.line "$" and vim.bo.filetype ~= "commit" then
      vim.cmd 'normal! g`"'
    end
  end,
})
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = "common",
  command = "set cursorline",
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = "common",
  command = "set nocursorline",
})
api.nvim_create_autocmd("CmdLineEnter", {
  group = "common",
  pattern = ":",
  command = "set nosmartcase",
})
api.nvim_create_autocmd("CmdLineLeave", {
  group = "common",
  pattern = ":",
  command = "set smartcase",
})
api.nvim_create_autocmd("VimResized", {
  group = "common",
  command = ":wincmd =",
})
api.nvim_create_autocmd("TextYankPost", {
  group = "common",
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end,
})

-- lsp
api.nvim_create_augroup("lsp_special", {})
api.nvim_create_autocmd("CursorHold", {
  group = "lsp_special",
  callback = function()
    if not (vim.b.lsp_floating_preview and api.nvim_win_is_valid(vim.b.lsp_floating_preview)) then
      vim.diagnostic.open_float { scope = "cursor" }
    end
  end,
})

-- visual-multi
local restored_bs_map -- restore <BS> for autopairs
api.nvim_create_augroup("visual_multi_special", {})
api.nvim_create_autocmd("User", {
  group = "visual_multi_special",
  pattern = "visual_multi_start",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    keymap.set("n", "<C-j>", "<Plug>(VM-Add-Cursor-Down)", { buffer = bufnr })
    keymap.set("n", "<C-k>", "<Plug>(VM-Add-Cursor-Up)", { buffer = bufnr })
    keymap.set("n", "<C-l>", "<Plug>(VM-Single-Select-l)", { buffer = bufnr })
    keymap.set("n", "<C-h>", "<Plug>(VM-Single-Select-h)", { buffer = bufnr })
    vim.cmd "Searchlight!"
    local keymaps = api.nvim_buf_get_keymap(bufnr, "i")
    for _, existing_map in ipairs(keymaps) do
      if existing_map.lhs == "<BS>" then
        restored_bs_map = existing_map
      end
    end
    keymap.del("i", "<BS>", { buffer = bufnr })
  end,
})
api.nvim_create_autocmd("User", {
  group = "visual_multi_special",
  pattern = "visual_multi_exit",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    keymap.del("n", "<C-j>", { buffer = bufnr })
    keymap.del("n", "<C-k>", { buffer = bufnr })
    keymap.del("n", "<C-l>", { buffer = bufnr })
    keymap.del("n", "<C-h>", { buffer = bufnr })
    vim.cmd "Searchlight"
    keymap.set(restored_bs_map.mode, restored_bs_map.lhs, restored_bs_map.rhs or restored_bs_map.callback, {
      noremap = restored_bs_map.noremap == 1,
      silent = restored_bs_map.silent == 1,
      expr = restored_bs_map.expr == 1,
      buffer = restored_bs_map.buffer,
    })
  end,
})

-- other filetypes
api.nvim_create_augroup("other_filetypes", {})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = { "asm", "gitcommit", "NeogitPopup", "NeogitStatus" },
  command = "setlocal nolist",
})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = "qf",
  command = "setlocal nolist | setlocal nobuflisted",
})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = "NeogitCommitMessage",
  command = "setlocal nolist | startinsert",
})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = "asm",
  command = "setlocal filetype=gas",
})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = "rnvimr",
  callback = function()
    keymap.set("t", "<M-i>", "<cmd>RnvimrResize<cr>", { buffer = api.nvim_get_current_buf(), silent = true })
  end,
})
api.nvim_create_autocmd("FileType", {
  group = "other_filetypes",
  pattern = "dap-repl",
  callback = function()
    require("dap.ext.autocompl").attach()
  end,
})
