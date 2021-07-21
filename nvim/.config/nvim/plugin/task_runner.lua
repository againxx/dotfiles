vim.g.asyncrun_open = 8
vim.g.asyncrun_rootmarks = {
  '.git',
  '.svn',
  '.root',
  '.project',
  '.hg'
}
vim.g.asynctasks_config_name = { '.tasks', '.vim/.tasks' }
vim.g.asynctasks_confirm = 0
vim.g.asynctasks_term_pos = 'tab'
vim.g.asynctasks_term_reuse = 1

local wk = require('which-key')
wk.register({
  name = '+refactor/run-tasks',
  r = { '<cmd>cclose<bar>AsyncTask file-run<cr>', 'Run current file' },
  b = { '<cmd>AsyncTask project-build<cr>', 'Build whole project' },
  B = { '<cmd>AsyncTask file-build<cr>', 'Build current file' },
  p = { '<cmd>AsyncTask project-run<cr>', 'Run whole file' },
  i = { '<cmd>AsyncTask project-init<cr>', 'Initialize project' },
  c = { '<cmd>AsyncTask project-clean<cr>', 'Clean project' },
  l = { require('telescope_config').asynctasks, 'List available tasks' },
}, { prefix = '<leader>r' })
