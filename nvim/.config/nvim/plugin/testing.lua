local g = vim.g

g["test#python#runner"] = "pytest"
g.test_project_root_patterns = { ".vim", ".git" }

local test_root_dir_exec = function(cmd)
  if g.test_project_root_patterns then
    local root_dir = require("xx.utils").find_bottom_up_project_root_dir(g.test_project_root_patterns)
    if root_dir then
      g["test#project_root"] = root_dir
    end
  end
  vim.cmd(cmd)
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>t", group = "test/task" },
  { "<leader>tf", function() test_root_dir_exec "TestFile" end, desc = "All tests in current file" },
  { "<leader>tl", function() test_root_dir_exec "TestLast" end, desc = "Last test" },
  { "<leader>tn", function() test_root_dir_exec "TestNearest" end, desc = "Nearest test" },
  { "<leader>to", function() test_root_dir_exec "TestVisit" end, desc = "Open last test file" },
  { "<leader>ts", function() test_root_dir_exec "TestSuite" end, desc = "Whole test suite" },
}
