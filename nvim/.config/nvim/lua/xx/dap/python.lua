local python_path = "~/.virtualenvs/debugpy/bin/python"
local conda_prefix = vim.env.CONDA_PREFIX
if conda_prefix then
  python_path = conda_prefix .. "/bin/python"
end

require("dap-python").setup(python_path)
require("dap-python").test_runner = "pytest"

local dap = require "dap"
for i = 1, #dap.configurations.python do
  dap.configurations.python[i] = vim.tbl_extend("force", dap.configurations.python[i], { justMyCode = false })
end

require("dapui").setup {
  sidebar = {
    open_on_start = false,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "stacks",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "watches", size = 0.25 },
    },
    size = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = { "scopes" },
    size = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    max_height = 0.6, -- These can be integers or a float between 0 and 1.
    max_width = 0.6, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
}

local set_debug_args = function()
  local default = vim.g.dap_python_args and table.concat(vim.g.dap_python_args, " ") or ""
  vim.g.dap_python_args = vim.split(vim.fn.input("Program arguments: ", default, "file"), " ")
  for i = 1, #dap.configurations.python do
    dap.configurations.python[i] = vim.tbl_extend(
      "force",
      dap.configurations.python[i],
      { args = vim.g.dap_python_args }
    )
  end
end

local wk = require "which-key"

wk.register({
  n = { "<cmd>lua require('dap-python').test_method()<cr>", "Test method" },
  s = { "<cmd>lua require('dap-python').test_class()<cr>", "Test class" },
  a = { set_debug_args, "Set debug arguments" },
}, {
  prefix = "<leader>d",
})
