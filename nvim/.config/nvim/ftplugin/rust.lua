local success, wk = pcall(require, "which-key")
if not success then
  return
end

local choice_project_target = function()
  local Job = require "plenary.job"
  local targets = {}
  Job
    :new({
      command = "cargo",
      args = { "run", "--color", "never", "--bin" },
      on_exit = function(j, _)
        for i, line in ipairs(j:stderr_result()) do
          if i > 2 and #line > 0 then
            table.insert(targets, vim.trim(line))
          end
        end
      end,
    })
    :sync()
  vim.ui.select(targets, {
    prompt = "Select a target to run:",
  }, function(choice)
    if choice then
      vim.cmd("AsyncTask project-run +run_target=" .. choice)
    end
  end)
end

vim.keymap.set("x", "K", function()
  require("rust-tools.hover_range").hover_range()
end, { silent = true })

bufnr = vim.api.nvim_get_current_buf()

wk.add {
  { "<leader>oC", "<cmd>RustOpenCargo<cr>", desc = "Open Cargo.toml", buffer = bufnr },
  { "<leader>rr", "<cmd>RustRunnables<cr>", desc = "Run runnables", buffer = bufnr },
  { "<ledaer>rp", choice_project_target, desc = "Build whole project", buffer = bufnr },
  { "<leader>dR", "<cmd>RustDebuggables<cr>", desc = "Debug debuggables", buffer = bufnr },
  { "<leader>rK", "<cmd>RustMoveItemUp<cr>", desc = "Move item up", buffer = bufnr },
  { "<leader>rJ", "<cmd>RustMoveItemDown<cr>", desc = "Move item down", buffer = bufnr },
}

-- add < into autopairs
-- local Rule = require('nvim-autopairs.rule')
-- local npairs = require('nvim-autopairs')
--
-- npairs.add_rule(Rule("<", ">", "rust"):with_move(function(opts)
--   if opts.char == ">" then
--     return true
--   end
--   return false
-- end))
