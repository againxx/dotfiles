require('xx.utils').set_indent(2)
local plugin_runtimes = vim.api.nvim_get_runtime_file("", true)
table.insert(plugin_runtimes, 1, '/usr/share/nvim/runtime/lua')
-- vim.fn['coc#config']('Lua.workspace.library', plugin_runtimes)
