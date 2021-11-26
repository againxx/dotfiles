local dap = require "dap"
local api = vim.api

local M = setmetatable({}, {
  __index = dap,
})

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "VimspectorBP", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◕", texthl = "VimspectorBPCond", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◐", texthl = "VimspectorBPCond", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "VimspectorPC", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "VimspectorBPCond", linehl = "", numhl = "" })
dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

require("nvim-dap-virtual-text").setup()
require("xx.dap." .. vim.bo.filetype)

local keymap_restore
dap.listeners.after["event_initialized"]["xx.mappings"] = function()
  local keymaps = api.nvim_get_keymap "n"
  for _, keymap in pairs(keymaps) do
    if keymap.lhs == "K" then
      keymap_restore = keymap
      api.nvim_del_keymap("n", "K")
      break
    end
  end
  api.nvim_set_keymap("n", "K", "<cmd>lua require('dap.ui.widgets').hover()<cr>", { silent = true })
  api.nvim_set_keymap("v", "K", "<cmd>lua require('dapui').hover()<cr>", { silent = true })
end

local close_post_hook = function()
  if keymap_restore then
    api.nvim_set_keymap(
      keymap_restore.mode,
      keymap_restore.lhs,
      keymap_restore.rhs,
      { noremap = keymap_restore.noremap == 1, silent = keymap_restore.silent == 1 }
    )
    keymap_restore = nil
    api.nvim_del_keymap("v", "K")
  end
  dap.repl.close()
  require("xx.utils").delete_finished_terminal_buffers()
  require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
end

function M.close()
  require("dapui").close()
  dap.disconnect()
  dap.close()
  vim.defer_fn(close_post_hook, 1000)
end

function M.set_debug_args()
  local ft = vim.bo.filetype
  local dap_args = "dap_" .. ft .. "_args"
  local default = vim.g[dap_args] and table.concat(vim.g[dap_args], " ") or ""
  vim.g[dap_args] = vim.split(vim.fn.input("Program arguments: ", default, "file"), " ")
  for i = 1, #dap.configurations[ft] do
    dap.configurations[ft][i] = vim.tbl_extend(
      "force",
      dap.configurations[ft][i],
      { args = vim.g[dap_args] }
    )
  end
end

return M
