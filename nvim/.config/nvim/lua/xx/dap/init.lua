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

local keymap_restore = {}
dap.listeners.after["event_initialized"]["xx"] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, "n")
    for _, keymap in ipairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, "n", "K")
      end
    end
  end
  vim.keymap.set({"n", "v"}, "K", require('dapui').eval, { silent = true })
end

local close_post_hook = function()
  for _, keymap in ipairs(keymap_restore) do
    vim.keymap.set(
      keymap.mode,
      keymap.lhs,
      keymap.rhs or keymap.callback,
      { noremap = keymap.noremap == 1, silent = keymap_restore.silent == 1, buffer = keymap.buffer }
    )
  end
  vim.F.npcall(vim.keymap.del, {"n", "v"}, "K")
  keymap_restore = {}
  dap.repl.close()
  require("xx.utils").delete_finished_terminal_buffers()
  require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
end

function M.close()
  require("dapui").close()
  dap.terminate()
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
