vim.g.asyncrun_open = 8
vim.g.asyncrun_rootmarks = {
  '.git',
  '.svn',
  '.vim',
  '.root',
  '.project',
  '.hg'
}
vim.g.asynctasks_config_name = '.vim/.tasks'
vim.g.asynctasks_confirm = 0
vim.g.asynctasks_term_pos = 'tab'
vim.g.asynctasks_term_reuse = 1

local change_build_profile = function()
  local profiles = { 'debug', 'release', 'release-debug' }
  for i, v in ipairs(profiles) do
    if v == vim.g.asynctasks_profile then
      vim.g.asynctasks_profile = i + 1 <= #profiles and profiles[i + 1] or profiles[1]
      break
    end
  end
  vim.notify("Change build profile into: " .. vim.g.asynctasks_profile)
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  r = {
    name = '+refactor/run-tasks',
    r = { '<cmd>cclose<bar>write %<bar>AsyncTask file-run<cr>', 'Run current file' },
    b = { '<cmd>AsyncTask project-build<cr>', 'Build whole project' },
    B = { '<cmd>AsyncTask file-build<cr>', 'Build current file' },
    p = { '<cmd>AsyncTask project-run<cr>', 'Run whole project' },
    i = { '<cmd>AsyncTask project-init<cr>', 'Initialize project' },
    c = { '<cmd>AsyncTask project-clean<cr>', 'Clean project' },
  },
  cp = { change_build_profile, 'Change build profile' },
  lr = { "<cmd>lua require('xx.telescope').asynctasks()<cr>", 'List available tasks' },
}, { prefix = '<leader>' })
