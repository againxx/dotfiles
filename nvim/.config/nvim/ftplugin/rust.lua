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

wk.register({
  oC = { "<cmd>RustOpenCargo<cr>", "Open Cargo.toml" },
  rr = { "<cmd>RustRunnables<cr>", "Run runnables" },
  rp = { choice_project_target, "Build whole project" },
  dR = { "<cmd>RustDebuggables<cr>", "Debug debuggables" },
}, {
  prefix = "<leader>",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  ["[a"] = { "<cmd>RustMoveItemUp<cr>", "Move item up" },
  ["]a"] = { "<cmd>RustMoveItemDown<cr>", "Move item down" },
}, {
  buffer = vim.api.nvim_get_current_buf(),
})

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
