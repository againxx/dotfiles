local dap = require('dap')

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local value = tonumber(vim.fn.input('Port: '))
      if value ~= "" then
        return value
      end
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8088 })
end

require('dapui').setup({
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<Tab>', '<2-LeftMouse>' },
  },
  layouts = {
    {
      open_on_start = false,
      elements = {
        "stacks",
        "breakpoints",
        "watches",
      },
      size = 50,
      position = "left",
    },
    {
      open_on_start = false,
      elements = { "scopes" },
      size = 20,
      position = "bottom",
    },
  }
})
