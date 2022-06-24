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

-- Code copy from dap-python
-- serve as a temporary solution, until the multi-session branch merged into master
local sessions = {}
local root_session

local remove_session = function(session)
  sessions[session] = nil
  if session == root_session then
    root_session = nil
  elseif dap.session() == session or dap.session() == nil then
    dap.set_session(root_session)
  end
end

dap.listeners.after.event_initialized["dap-python"] = function(session)
  sessions[session] = true
  if not root_session then
    root_session = session
  end
end
dap.listeners.after.event_exited["dap-python"] = remove_session
dap.listeners.after.event_terminated["dap-python"] = remove_session
dap.listeners.after.disconnected["dap-python"] = remove_session
dap.listeners.after["event_debugpyAttach"]["dap-python"] = function(_, config)
  local adapter = {
    host = config.connect.host,
    port = config.connect.port,
  }
  local session
  local connect_opts = {}
  session = require("dap.session"):connect(adapter, connect_opts, function(err)
    if err then
      vim.notify("Error connecting to subprocess session: " .. vim.inspect(err), vim.log.levels.WARN)
    elseif session then
      session:initialize(config)
      dap.set_session(session)
      vim.schedule(function()
        require("dapui").open(1)
      end)
    end
  end)
end

require("dapui.config").elements["SUBPROCESSES"] = "subprocesses"

require("dapui").setup {
  layouts = {
    {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        -- "stacks",
        "subprocesses",
        "breakpoints",
        "watches",
      },
      size = 50,
      position = "left", -- Can be "left" or "right"
    },
    {
      elements = { "scopes" },
      size = 15,
      position = "bottom", -- Can be "bottom" or "top"
    },
  },
  floating = {
    max_height = 0.6, -- These can be integers or a float between 0 and 1.
    max_width = 0.6, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
}

local wk = require "which-key"

wk.register({
  n = { "<cmd>lua require('dap-python').test_method()<cr>", "Test method" },
  s = { "<cmd>lua require('dap-python').test_class()<cr>", "Test class" },
}, {
  prefix = "<leader>d",
})
