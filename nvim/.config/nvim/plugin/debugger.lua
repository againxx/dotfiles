vim.g.dap_virtual_text = true

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  name = "+debugger/diagnostic",
  d = { "<cmd>lua require('xx.dap').continue()<cr>", 'Continue' },
  q = { "<cmd>lua require('xx.dap').close()<cr>", 'Stop' },
  l = { "<cmd>lua require('xx.dap').step_into({askForTargets = true})<cr>", 'Step into' },
  j = { "<cmd>lua require('xx.dap').step_over()<cr>", 'Step over' },
  k = { "<cmd>lua require('xx.dap').step_out()<cr>", 'Step out' },
  h = { "<cmd>lua require('dapui').eval()<cr>", 'Evaluate expression' },
  c = { "<cmd>lua require('xx.dap').run_to_cursor()<cr>", 'Run to cursor' },
  r = { "<cmd>lua require('xx.dap').restart()<cr>", 'Restart' },
  i = { "<cmd>lua require('xx.dap').toggle_breakpoint(vim.fn.input('Breakpoint condigtion: '))<cr>", 'Toggle conditional breakpoint' },
  u = { "<cmd>lua require('dapui').toggle()<cr>", 'Toggle ui' },
  t = { "<cmd>lua require('dapui').toggle('tray')<cr>", 'Toggle tray ui' },
  e = { "<cmd>lua require('dapui').toggle('sidebar')<cr>", 'Toggle sidebar ui' },
  b = { "<cmd>lua require('xx.dap').list_breakpoints()<cr>", 'List all breakpoints' },
  [';'] = { "<cmd>lua require('xx.dap').toggle_breakpoint()<cr>", 'Toggle breakpoint' },
}, { prefix = '<leader>d' })
