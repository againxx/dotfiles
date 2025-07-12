vim.opt_local.foldlevel = 1
vim.opt_local.colorcolumn = "101"

-- vim.fn['coc#config']('snippets.loadFromExtensions', 0)
-- vim.fn['coc#config']('diagnostic-languageserver.linters', {
--   mypy = {
--     args = {
--       '--no-color-output',
--       '--no-error-summary',
--       '--show-column-numbers',
--       '--follow-imports=silent',
--       '--cache-dir=' .. vim.env.HOME .. '/.cache/mypy',
--       '%file'
--     }
--   }
-- })
-- dynamically set python.condaPath
-- if vim.env.CONDA_PREFIX then
--   vim.fn['coc#config']('python.condaPath', vim.env.CONDA_PREFIX .. '/bin/python')
-- end

local switch_definitions = [[
  let b:switch_custom_definitions = [
    {
      'print\s\+\(.*\)': 'print(\1)',
      'print(\([^)]*\))': 'print \1',
      'is\s\(not\)\@!': 'is not ',
      'is\snot': 'is',
    }
  ]
]]
vim.cmd(switch_definitions:gsub("\n", ""))

local success, wk = pcall(require, "which-key")
if not success then
  return
end

local bufnr = vim.api.nvim_get_current_buf()

wk.add {
  { "<space><space>", '0/TODO<cr><cmd>nohlsearch<cr>"_c4l', buffer = bufnr, desc = "Replace next TODO" },
  { "[i", "?def __init__<cr><cmd>nohlsearch<cr>", buffer = bufnr, desc = "Goto previous __init__" },
  { "]i", "/def __init__<cr><cmd>nohlsearch<cr>", buffer = bufnr, desc = "Goto next __init__" },
}

if vim.g.colors_name == "ayu" then
  vim.cmd [[hi pythonTSSelf gui=italic guifg=#B695E0 guibg=NONE]]
  vim.cmd [[hi pythonTSInclude gui=bold,italic guifg=#FFD580]]
  vim.cmd [[hi! link pythonTSDocstring pythonComment]]
  vim.cmd [[hi! link pythonTSField Normal]]
end
