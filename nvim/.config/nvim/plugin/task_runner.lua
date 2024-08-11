vim.g.asyncrun_open = 8
vim.g.asyncrun_rootmarks = {
  ".git",
  ".svn",
  ".vim",
  ".root",
  ".project",
  ".hg",
}
vim.g.asynctasks_config_name = ".vim/.tasks"
vim.g.asynctasks_confirm = 0
vim.g.asynctasks_term_pos = "tab"
vim.g.asynctasks_term_reuse = 1

local change_build_profile = function()
  local profiles = { "debug", "release", "release-debug" }
  for i, v in ipairs(profiles) do
    if v == vim.g.asynctasks_profile then
      vim.g.asynctasks_profile = i + 1 <= #profiles and profiles[i + 1] or profiles[1]
      break
    end
  end
  vim.notify("Change build profile into: " .. vim.g.asynctasks_profile)
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>cp", change_build_profile, desc = "Change build profile" },
  { "<leader>lr", "<cmd>lua require('xx.telescope').asynctasks()<cr>", desc = "List available tasks" },
  { "<leader>r", group = "refactor/run-tasks" },
  { "<leader>rB", "<cmd>AsyncTask file-build<cr>", desc = "Build current file" },
  { "<leader>rb", "<cmd>AsyncTask project-build<cr>", desc = "Build whole project" },
  { "<leader>rc", "<cmd>AsyncTask project-clean<cr>", desc = "Clean project" },
  { "<leader>ri", "<cmd>AsyncTask project-init<cr>", desc = "Initialize project" },
  { "<leader>rp", "<cmd>AsyncTask project-run<cr>", desc = "Run whole project" },
  { "<leader>rr", "<cmd>cclose<bar>write %<bar>AsyncTask file-run<cr>", desc = "Run current file" },
}
