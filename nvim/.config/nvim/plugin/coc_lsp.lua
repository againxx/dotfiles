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
local cmd = vim.cmd

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

local show_documentation = function()
  if vim.tbl_contains({ 'vim', 'help', 'lua' }, vim.bo.filetype) then
    if vim.bo.filetype == 'lua' and not fn.expand('<cWORD>'):match('vim%.') then
      fn.CocAction('doHover')
    else
      cmd('h ' .. fn.expand('<cword>'))
    end
  else
    fn.CocAction('doHover')
  end
end

function _G.UltisnipsExpandOrUseCocCompletion()
  fn['UltiSnips#ExpandSnippet']()
  if vim.g.ulti_expand_res > 0 then
    cmd('pclose')
    return ''
  elseif fn.complete_info().selected ~= -1 or fn.pumvisible() > 0 then
    return api.nvim_replace_termcodes('<C-y>', true, false, true)
  else
    return api.nvim_replace_termcodes('<C-g>u<Tab>', true, false, true)
  end
end

-- Use <Tab> to expand snippet or confirm completion
api.nvim_set_keymap('i', '<Tab>', '<C-r>=v:lua.UltisnipsExpandOrUseCocCompletion()<cr>', { noremap = true, silent = true })

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

-- GoTo code navigation.
wk.register({
  d = { "<cmd>lua require('xx.telescope').coc.definitions()<cr>", 'Go to definitions' },
  l = { "<cmd>lua require('xx.telescope').coc.declarations()<cr>", 'Go to declarations' },
  L = { "<cmd>lua require('xx.telescope').coc.implementations()<cr>", 'Go to implementations' },
  r = { "<cmd>lua require('xx.telescope').coc.references{}<cr>", 'Go to references' },
  y = { "<cmd>lua require('xx.telescope').coc.type_definitions({})<cr>", 'Go to type definitions' },
  q = { '<Plug>(coc-format-selected)', 'Format by motion' },
  qq = { '<Plug>(coc-format-selected)j', 'Format current line' },
}, { prefix = 'g' })

-- navigate diagnostics & show documentation
wk.register({
  ['[e'] = { '<Plug>(coc-diagnostic-prev-error)', 'Go to previous error' },
  [']e'] = { '<Plug>(coc-diagnostic-next-error)', 'Go to next error' },
  ['[w'] = { '<Plug>(coc-diagnostic-prev)', 'Go to previous diagnostic' },
  [']w'] = { '<Plug>(coc-diagnostic-next)', 'Go to next diagnostic' },
  K = { show_documentation, 'Preview documentation or open help page' }
})

wk.register({
  g = { "<cmd>lua require('xx.telescope').coc.diagnostics()<cr>", 'Current buffer diagnostics' },
  G = { "<cmd>lua require('xx.telescope').coc.workspace_diagnostics()<cr>", 'Workspace diagnostics' },
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
    a = { "<cmd>lua require('xx.toggles').change_diagnostic_level()<cr>", 'Change diagnostic level' },
    l = { "<cmd>lua require('xx.toggles').toggle_code_lens()<cr>", 'Toggle code lens' },
    b = { "<cmd>lua require('xx.toggles').toggle_git_blame()<cr>", 'Toggle git blame' },
    D = { "<cmd>lua require('xx.toggles').toggle_diagnostic()<cr>", 'Toggle diagnostic' },
    C = { "<cmd>lua require('xx.toggles').toggle_error_code()<cr>", 'Toggle error code' },
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
