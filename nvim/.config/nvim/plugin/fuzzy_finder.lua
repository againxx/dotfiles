local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>P", "<cmd>lua require('xx.telescope').grep_prompt()<cr>", desc = "Grep string with prompt" },
  { "<leader>cc", "<cmd>lua require('xx.telescope').commands()<cr>", desc = "Vim commands" },
  { "<leader>f", group = "find/file" },
  { "<leader>f/", "<cmd>lua require('xx.telescope').grep_last_search()<cr>", desc = "Grep last search" },
  {
    "<leader>fF",
    "<cmd>lua require('xx.telescope').find_files({hidden=true, no_ignore=true})<cr>",
    desc = "Files in current folder (ignore & hidden)",
  },
  { "<leader>fR", "<cmd>lua require('xx.telescope').ros_core_packages()<cr>", desc = "Core ros packages" },
  { "<leader>fb", "<cmd>lua require('xx.telescope').buffers()<cr>", desc = "Buffers" },
  { "<leader>fd", "<cmd>lua require('xx.telescope').list_z_dirs()<cr>", desc = "Directories of z.lua" },
  { "<leader>fe", "<cmd>lua require('xx.telescope').file_browser()<cr>", desc = "File browser" },
  { "<leader>ff", "<cmd>lua require('xx.telescope').find_files()<cr>", desc = "Files in current folder" },
  { "<leader>fg", "<cmd>lua require('xx.telescope').git_files()<cr>", desc = "Git files" },
  { "<leader>fh", "<cmd>lua require('xx.telescope').help_tags()<cr>", desc = "Helps" },
  { "<leader>fm", "<cmd>lua require('xx.telescope').man_pages()<cr>", desc = "Man pages" },
  { "<leader>fo", "<cmd>lua require('xx.telescope').oldfiles()<cr>", desc = "Recent files" },
  { "<leader>fp", "<cmd>lua require('xx.telescope').projects()<cr>", desc = "Project files" },
  { "<leader>fr", "<cmd>lua require('xx.telescope').ros_workspace_packages()<cr>", desc = "Worksapce ros packages" },
  { "<leader>l", group = "list" },
  { "<leader>lC", "<cmd>lua require('xx.telescope').quickfix()<cr>", desc = "Fuzzy find quickfix" },
  { "<leader>lL", "<cmd>lua require('xx.telescope').loclist()<cr>", desc = "Fuzzy find location list" },
  { "<leader>lc", "<cmd>QFToggle!<cr>", desc = "Toggle quickfix" },
  { "<leader>ll", "<cmd>LLToggle!<cr>", desc = "Toggle location list" },
  { "<leader>o", group = "open/history" },
  { "<leader>o/", "<cmd>lua require('xx.telescope').search_history()<cr>", desc = "Search history" },
  { "<leader>oc", "<cmd>lua require('xx.telescope').command_history()<cr>", desc = "Command history" },
  { "<leader>ok", "<cmd>lua require('xx.telescope').keymaps()<cr>", desc = "Key mappings" },
  { "<leader>om", "<cmd>lua require('xx.telescope').marks()<cr>", desc = "Marks" },
  { "<leader>oo", "<cmd>lua require('xx.telescope').jumplist()<cr>", desc = "Jump list" },
  { "<leader>or", "<cmd>lua require('xx.telescope').registers()<cr>", desc = "Registers" },
  { "<leader>ou", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
  { "<leader>p", "<cmd>lua require('xx.telescope').grep_cursor_word()<cr>", desc = "Grep word under cursor" },
  { "<leader>s", group = "symbol/session/show/search" },
  { "<leader>sa", "<cmd>lua require('xx.telescope').workspace_symbols()<cr>", desc = "Workspace symbols" },
  { "<leader>ss", "<cmd>lua require('xx.telescope').document_symbols()<cr>", desc = "Document symbols" },
  { "<leader>y", group = "yank" },
  { "<leader>yy", "<cmd>lua require('xx.telescope').neoclip_yank()<cr>", desc = "Yank history" },
}

wk.add {
  {
    "<C-_>",
    function()
      require("xx.telescope").current_buffer_fuzzy_find(vim.fn.expand "<cword>")
    end,
    desc = "Current buffer fuzzy find",
  },
  { "<C-p>", "<cmd>lua require('xx.telescope').live_grep()<cr>", desc = "Live grep" },
  { "<leader>p", "<cmd>lua require('xx.telescope').grep_selected()<cr>", desc = "Grep from selected", mode = "x" },
}
