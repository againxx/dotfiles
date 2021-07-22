-- Extensions
vim.g.coc_global_extensions = {
  'coc-json',
  'coc-pyright',
  'coc-yank',
  'coc-lists',
  'coc-git',
  'coc-explorer',
  'coc-actions',
  'coc-cmake',
  'coc-highlight',
  'coc-pairs',
  'coc-vimlsp',
  'coc-snippets',
  'coc-zi',
  'coc-ci',
  'coc-spell-checker',
  'coc-ultisnips',
  'coc-omni',
  'coc-sh',
  'coc-translator',
  'coc-clangd',
  'coc-tsserver',
  'coc-html',
  'coc-diagnostic',
  'coc-rls',
  'coc-lua'
}

local fn = vim.fn
local api = vim.api

-- functions
local toggle_error_code = function()
  if fn['coc#util#get_config']('diagnostic').format == '%message\n[%source]' then
    fn['coc#config']('diagnostic.format', '%message\n[%source:%code]')
  else
    fn['coc#config']('diagnostic.format', '%message\n[%source]')
  end
end

local change_diagnostic_level = function()
  if fn['coc#util#get_config']('diagnostic').level == 'warning' then
    fn['coc#config']('diagnostic.level', 'hint')
  else
    fn['coc#config']('diagnostic.level', 'warning')
  end
  fn.CocActionAsync('diagnosticRefresh', api.nvim_get_current_buf())
end

local toggle_code_lens = function()
  if fn['coc#util#get_config']('codeLens').enable > 0 then
    fn['coc#config']('codeLens.enable', 0)
  else
    fn['coc#config']('codeLens.enable', 1)
  end
  if vim.bo.filetype == 'rust' then
    vim.cmd('CocCommand rust-analyzer.toggleInlayHints')
  end
end

local toggle_git_blame = function()
  if fn['coc#util#get_config']('git').addGBlameToVirtualText > 0 then
    fn['coc#config']('git.addGBlameToVirtualText', 0)
  else
    fn['coc#config']('git.addGBlameToVirtualText', 1)
  end
end

local toggle_diagnostic = function()
  if vim.b.coc_diagnostic_disable and vim.b.coc_diagnostic_disable > 0 then
    vim.b.coc_diagnostic_disable = 0
  else
    vim.b.coc_diagnostic_disable = 1
  end
  vim.cmd('doautocmd BufEnter')
end

local get_diagnostic_codes = function()
  local coc_diagnostics = fn.CocAction('diagnosticList')
  local current_line = api.nvim_get_current_line()
  local current_file_path = fn.expand('%:p')
  local codes = {}
  for _, diagnostic in ipairs(coc_diagnostics) do
    if diagnostic.file == current_file_path and current_line == diagnostic.lnum
      and diagnostic.location.range.start.character < fn.col('.')
      and fn.col('.') <= diagnostic.location.range['end'].character then
      table.insert(codes, diagnostic.code)
    end
  end
  return codes
end

local yank_diagnostic_codes = function()
  local codes = table.concat(get_diagnostic_codes(), ' ')
  fn.setreg('@', codes)
  fn.setreg('+', codes)
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

-- GoTo code navigation.
wk.register({
  d = { '<cmd>Telescope coc definitions<cr>', 'Go to definitions' },
  l = { '<cmd>Telescope coc declarations<cr>', 'Go to declarations' },
  L = { '<cmd>Telescope coc implementations<cr>', 'Go to implementations' },
  r = { '<cmd>Telescope coc references<cr>', 'Go to references' },
  y = { '<cmd>Telescope coc type_definitions<cr>', 'Go to type definitions' },
  q = { '<Plug>(coc-format-selected)', 'Format by motion' },
  qq = { '<Plug>(coc-format-selected)j', 'Format current line' },
}, { prefix = 'g' })

-- navigate diagnostics
wk.register({
  ['[e'] = { '<Plug>(coc-diagnostic-prev-error)', 'Go to previous error' },
  [']e'] = { '<Plug>(coc-diagnostic-next-error)', 'Go to next error' },
  ['[w'] = { '<Plug>(coc-diagnostic-prev)', 'Go to previous diagnostic' },
  [']w'] = { '<Plug>(coc-diagnostic-next)', 'Go to next diagnostic' },
})

wk.register({
  g = { '<cmd>Telescope coc diagnostics<cr>', 'Current buffer diagnostics' },
  G = { '<cmd>Telescope coc workspace_diagnostics<cr>', 'Workspace diagnostics' },
}, { prefix = '<leader>d' })

wk.register({
  name = '+action',
  a = { '<Plug>(coc-codeaction-cursor)', 'Action under cursor' },
  l = { '<Plug>(coc-codeaction-line)', 'Action for current line' },
  f = { '<Plug>(coc-codeaction)', 'Action for file' },
}, { prefix = '<leader>a' })

wk.register({
  ['<leader>a'] = { '<Plug>(coc-codeaction-selected)', 'Action for selected' },
  ['<leader>T'] = { '<Plug>(coc-translator-pv)', 'Translate' },
  gq = { '<Plug>(coc-format-selected)', 'Translate' }
}, { mode = 'x' })

wk.register({
  oS = { '<cmd>CocList --normal sources<cr>', 'Coc sources' },
  T = { '<Plug>(coc-translator-p)', 'Translate' },
  y = {
    name = '+yank',
    y = { '<cmd>CocList -A --normal yank<cr>', 'Yank history' },
    c = { yank_diagnostic_codes, 'Yank diagnostic code' },
  },
  r = {
    f = { '<Plug>(coc-format)', 'Format the whole file' },
    x = { '<Plug>(coc-fix-current)', 'Run current fix' },
    n = { '<Plug>(coc-rename)', 'Rename symbol' },
  },
  c = {
    name = '+change/command',
    a = { change_diagnostic_level, 'Change diagnostic level' },
    l = { toggle_code_lens, 'Toggle code lens' },
    b = { toggle_git_blame, 'Toggle git blame' },
    D = { toggle_diagnostic, 'Toggle diagnostic' },
    C = { toggle_error_code, 'Toggle error code' },
    g = { '<cmd>CocCommand git.toggleGutters<cr>', 'Toggle gutters' },
    s = { '<cmd>CocCommand cSpell.toggleEnableSpellChecker<cr>', 'Toggle spell checker' }
  }
}, { prefix = '<leader>' })

-- Introduce function & class text object
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
wk.register({
  ['if'] = { '<Plug>(coc-funcobj-i)', 'inner function' },
  af = { '<Plug>(coc-funcobj-a)', 'a function (with function signature)' },
  ic = { '<Plug>(coc-classobj-i)', 'inner class' },
  ac = { '<Plug>(coc-classobj-a)', 'a class (with class name)' },
}, { mode = 'x' })

wk.register({
  ['if'] = { '<Plug>(coc-funcobj-i)', 'inner function' },
  af = { '<Plug>(coc-funcobj-a)', 'a function (with function signature)' },
  ic = { '<Plug>(coc-classobj-i)', 'inner class' },
  ac = { '<Plug>(coc-classobj-a)', 'a class (with class name)' },
}, { mode = 'o' })
