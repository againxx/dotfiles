local dap = require('dap')

dap.adapters.cppdbg = {
  type = 'executable',
  command = vim.env.HOME .. '/Manually_Installed/cpptools-linux/extension/debugAdapters/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch (GDB)",
    type = "cppdbg",
    request = "launch",
    program = function()
      if not (vim.b.catkin_workspace and vim.b.dap_last_executable) then
        local default = vim.b.dap_last_executable or vim.fn.getcwd() .. '/'
        vim.b.dap_last_executable = vim.fn.input('Path to executable: ', default, 'file')
      end
      assert(vim.b.dap_last_executable, "Please provide valid executable file")
      return vim.b.dap_last_executable
    end,
    MIMode = 'gdb',
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        description = 'Enable pretty-printing for gdb',
        text = '-enable-pretty-printing',
        ignoreFailures = true
      },
    }
  },
}

require('dapui').setup({
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<Tab>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
  },
  sidebar = {
    open_on_start = false,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = 'stacks',
        size = 0.33, -- Can be float or integer > 1
      },
      { id = 'breakpoints', size = 0.33 },
      { id = 'watches', size = 0.33 },
    },
    width = 40,
    position = 'left', -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = { 'scopes' },
    height = 20,
    position = 'bottom', -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = 0.6, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
})

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  f = { "<cmd>lua require('xx.telescope').find_ros_executables()<cr>", 'Continue' },
}, { prefix = '<leader>d', buffer = vim.api.nvim_get_current_buf() })
