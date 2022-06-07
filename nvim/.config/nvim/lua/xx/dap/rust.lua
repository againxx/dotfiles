
-- rust-tools.nvim will setup these for us

-- local dap = require "dap"
-- dap.adapters.lldb = {
--   type = "executable",
--   command = "/usr/bin/lldb-vscode",
--   name = "lldb",
-- }
--
-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       local has_last_executable = false
--       if
--         vim.b.dap_last_executable
--         and #vim.b.dap_last_executable > 0
--         and vim.fn.executable(vim.b.dap_last_executable) > 0
--       then
--         has_last_executable = true
--       end
--       local default = has_last_executable and vim.b.dap_last_executable or vim.fn.getcwd() .. "/"
--       vim.b.dap_last_executable = vim.fn.input("Path to executable: ", default, "file")
--       assert(
--         #vim.b.dap_last_executable > 0 and vim.fn.executable(vim.b.dap_last_executable) > 0,
--         "Please provide valid executable file"
--       )
--       return vim.b.dap_last_executable
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--     args = {},
--     runInTerminal = true,
--   },
-- }

require("dapui").setup {
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<Tab>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    open_on_start = false,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "stacks",
        size = 0.33, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.33 },
      { id = "watches", size = 0.33 },
    },
    size = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = { "scopes" },
    size = 20,
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    max_height = 0.6, -- These can be integers or a float between 0 and 1.
    max_width = 0.6, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
}
