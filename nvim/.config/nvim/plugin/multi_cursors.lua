vim.g.VM_set_statusline = 2
vim.g.VM_silent_exit = true
vim.g.VM_quit_after_leaving_insert_mode = true

vim.g.VM_leader = "<Leader>v"
vim.g.VM_maps = {
  ["Add Cursor Down"] = "<Leader>vj",
  ["Add Cursor Up"] = "<Leader>vk",
  ["Select l"] = "<Leader>vl",
  ["Select h"] = "<Leader>vh",
  ["Reselect Last"] = "<Leader>v.",
  ["Toggle Mappings"] = "<Leader>v;",
  ["Run Visual"] = "<Leader>v<C-v>",
  ["Add Cursor At Pos"] = "<Leader>vv",
  ["Move Right"] = "<M-S-l>",
  ["Move Left"] = "<M-S-h>",
}

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>v", group = "multi-cursors" },
  { '<leader>v"', desc = "Show registers" },
  { "<leader>v.", desc = "Reselect last" },
  { "<leader>v/", desc = "Regex search" },
  { "<leader>v;", desc = "Toggle mappings" },
  { "<leader>v<", desc = "Align by character" },
  { "<leader>v<C-a>", desc = "Increase alphabet" },
  { "<leader>v<C-v>", desc = "Run visual command" },
  { "<leader>v<C-x>", desc = "Decrease alphabet" },
  { "<leader>v<cr>", desc = "Toggle single region" },
  { "<leader>v>", desc = "Align by regex" },
  { "<leader>v@", desc = "Run macro" },
  { "<leader>vA", desc = "Select all" },
  { "<leader>vC", desc = "Case conversion menu" },
  { "<leader>vN", desc = "Prepend numbers" },
  { "<leader>vV", desc = "Run last visual command" },
  { "<leader>vZ", desc = "Run last normal command" },
  { "<leader>v`", desc = "Tools menu" },
  { "<leader>va", desc = "Align cursor" },
  { "<leader>vc", desc = "Case setting" },
  { "<leader>vh", desc = "Select left" },
  { "<leader>vj", desc = "Add cursor down" },
  { "<leader>vk", desc = "Add cursor up" },
  { "<leader>vl", desc = "Select right" },
  { "<leader>vn", desc = "Append numbers" },
  { "<leader>vs", desc = "Split region" },
  { "<leader>vv", desc = "Add cursor at current position" },
  { "<leader>vz", desc = "Run normal command" },
}
