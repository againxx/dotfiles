local dap = require('dap')
local api = vim.api

local M = setmetatable({}, {
  __index = dap
})

vim.fn.sign_define('DapBreakpoint',         { text = '●', texthl = 'VimspectorBP',     linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint',           { text = '◐', texthl = 'VimspectorBPCond', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',            { text = '', texthl = 'VimspectorPC',     linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'VimspectorBPCond', linehl = '', numhl = '' })
dap.defaults.fallback.terminal_win_cmd = 'belowright 10new'

require('xx.dap.' .. vim.bo.filetype)

local keymap_restore
dap.listeners.after['event_initialized']['xx.mappings'] = function()
  local keymaps = api.nvim_get_keymap('n')
  for _, keymap in pairs(keymaps) do
    if keymap.lhs == "K" then
      keymap_restore = keymap
      api.nvim_del_keymap('n', 'K')
      break
    end
  end
  api.nvim_set_keymap(
    'n', 'K', "<cmd>lua require('dapui').eval()<cr>", { silent = true })
end

local close_post_hook = function()
  api.nvim_set_keymap(
    keymap_restore.mode,
    keymap_restore.lhs,
    keymap_restore.rhs,
    { noremap = keymap_restore.noremap == 1, silent = keymap_restore.silent == 1 }
  )
  keymap_restore = nil
  dap.repl.close()
  require('xx.utils').delete_finished_terminal_buffers()
  require('nvim-dap-virtual-text.virtual_text').clear_virtual_text()
end

function M.close()
  require('dapui').close()
  dap.disconnect()
  dap.close()
  vim.defer_fn(close_post_hook, 1000)
end

return M
