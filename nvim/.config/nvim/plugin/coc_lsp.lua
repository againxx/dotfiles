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

-- Use w/b to move over chinese ci
vim.cmd [[nmap <silent> w <Plug>(coc-ci-w)]]
vim.cmd [[nmap <silent> b <Plug>(coc-ci-b)]]

local wk = require('which-key')

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
  yy = { '<cmd>CocList -A --normal yank<cr>', 'Yank history' },
  r = {
    f = { '<Plug>(coc-format)', 'Format the whole file' },
    x = { '<Plug>(coc-fix-current)', 'Run current fix' },
    n = { '<Plug>(coc-rename)', 'Rename symbol' },
  }
}, { prefix = '<leader>' })

-- Introduce function text object
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.cmd([[
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ic <Plug>(coc-classobj-i)
  omap ac <Plug>(coc-classobj-a)
]])
