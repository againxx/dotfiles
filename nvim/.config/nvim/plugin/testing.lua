local fn = vim.fn
local g = vim.g

g['test#python#runner'] = 'pytest'
g.test_project_root_pattern = { '.vim', '.git' }

local test_root_dir_exec = function(cmd)
  if g.test_project_root_pattern then
    for _, pattern in pairs(g.test_project_root_pattern) do
      local root_dir = fn.finddir(pattern, '.;' .. os.getenv('HOME'))
      if fn.empty(root_dir) > 0 then
        g['test#project_root'] = fn.fnamemodify(root_dir, ':h')
      end
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
