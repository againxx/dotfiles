local python_path = '~/.virtualenvs/debugpy/bin/python'
local conda_prefix = os.getenv('CONDA_PREFIX')
if conda_prefix then
  python_path = conda_prefix .. '/bin/python'
end
require('dap-python').setup(python_path)
require('dap-python').test_runner = 'pytest'

require("dapui").setup({
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
    width = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = { 'scopes' },
    height = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
})

local wk = require('which-key')

wk.register({
  f = { "<cmd>lua require('dap-python').test_method()<cr>", 'Test method' },
  s = { "<cmd>lua require('dap-python').test_class()<cr>", 'Test class' },
}, { prefix = '<leader>d', buffer = vim.api.nvim_get_current_buf() })
