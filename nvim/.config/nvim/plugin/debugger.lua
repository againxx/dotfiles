local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>d", group = "debugger/diagnostic" },
  { "<leader>d;", "<cmd>lua require('xx.dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
  { "<leader>dR", "<cmd>lua require('xx.dap').restart()<cr>", desc = "Restart" },
  { "<leader>da", "<cmd>lua require('xx.dap').set_debug_args()<cr>", desc = "Set debug arguments" },
  { "<leader>db", "<cmd>lua require('xx.dap').list_breakpoints()<cr>", desc = "List all breakpoints" },
  { "<leader>dc", "<cmd>lua require('xx.dap').run_to_cursor()<cr>", desc = "Run to cursor" },
  { "<leader>dd", "<cmd>lua require('xx.dap').continue()<cr>", desc = "Continue" },
  { "<leader>de", "<cmd>lua require('dapui').toggle(1)<cr>", desc = "Toggle sidebar ui" },
  { "<leader>dh", "<cmd>lua require('dapui').eval()<cr>", desc = "Evaluate expression" },
  {
    "<leader>di",
    "<cmd>lua require('xx.dap').toggle_breakpoint(vim.fn.input('Breakpoint condigtion: '))<cr>",
    desc = "Toggle conditional breakpoint",
  },
  { "<leader>dj", "<cmd>lua require('xx.dap').step_over()<cr>", desc = "Step over" },
  { "<leader>dk", "<cmd>lua require('xx.dap').step_out()<cr>", desc = "Step out" },
  { "<leader>dl", "<cmd>lua require('xx.dap').step_into({askForTargets = true})<cr>", desc = "Step into" },
  { "<leader>dp", "<cmd>lua require('osv').launch({port = 8088})<cr>", desc = "Debug plugin" },
  { "<leader>dq", "<cmd>lua require('xx.dap').close()<cr>", desc = "Stop" },
  { "<leader>dr", "<cmd>lua require('xx.dap').repl.toggle()<cr>", desc = "Open repl" },
  { "<leader>dt", "<cmd>lua require('dapui').toggle(2)<cr>", desc = "Toggle tray ui" },
  { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle ui" },
  { "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", desc = "Toggle virtual text" },
}

