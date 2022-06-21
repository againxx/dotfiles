-- rust-tools.nvim will setup adapter and configurations for us

require("dapui").setup {
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<Tab>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    {
      open_on_start = false,
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        "stacks",
        "breakpoints",
        "watches",
      },
      size = 50,
      position = "left", -- Can be "left" or "right"
    },
    {
      open_on_start = false,
      elements = { "scopes" },
      size = 20,
      position = "bottom", -- Can be "bottom" or "top"
    },
  },
  floating = {
    max_height = 0.6, -- These can be integers or a float between 0 and 1.
    max_width = 0.6, -- Floats will be treated as percentage of your screen.
  },
  windows = { indent = 1 },
}
