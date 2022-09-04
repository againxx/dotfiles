local g = vim.g

g['test#python#runner'] = 'pytest'
g.test_project_root_patterns = { '.vim', '.git' }

local test_root_dir_exec = function(cmd)
  if g.test_project_root_patterns then
    local root_dir = require('xx.utils').find_bottom_up_project_root_dir(g.test_project_root_patterns)
    if root_dir then
      g['test#project_root'] = root_dir
    end
  end
  vim.cmd(cmd)
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  name = '+test/task',
  n = { function() test_root_dir_exec('TestNearest') end, 'Nearest test' },
  f = { function() test_root_dir_exec('TestFile') end, 'All tests in current file' },
  s = { function() test_root_dir_exec('TestSuite') end, 'Whole test suite' },
  l = { function() test_root_dir_exec('TestLast') end, 'Last test' },
  o = { function() test_root_dir_exec('TestVisit') end, 'Open last test file' },
}, { prefix = '<leader>t' })
