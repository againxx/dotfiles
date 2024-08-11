if vim.fn.executable "nvr" > 0 then
  vim.fn.setenv("GIT_EDITOR", "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'")
end

local gs_success, gitsigns = pcall(require, "gitsigns")
if not gs_success then
  return
end

gitsigns.setup {
  signs = {
    add = { text = "▎" },
    change = { text = "░" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "▒" },
  },
}

local on_mergetool_set_layout = function(split)
  if split.layout == "mr,b" and split.split == "b" then
    vim.wo.diff = false
    vim.cmd "resize 15"
  end
end

vim.g.MergetoolSetLayoutCallback = on_mergetool_set_layout

local wk_success, wk = pcall(require, "which-key")
if not wk_success then
  return
end

wk.add {
  { "<leader><C-g>", "<cmd>Lazygit<cr>", desc = "Lazygit" },
  { "<leader>c", group = "change/command" },
  { "<leader>ga", gitsigns.stage_hunk, desc = "Stage hunk" },
  { "<leader>gu", gitsigns.undo_stage_hunk, desc = "Undo stage hunk" },
  { "<leader>gr", gitsigns.reset_hunk, desc = "Reset hunk" },
  { "<leader>gR", gitsigns.reset_buffer, desc = "Reset current buffer" },
  -- show chunk diff at current position
  { "<leader>gd", gitsigns.preview_hunk, desc = "Hunk diff" },
  { "<leader>gD", gitsigns.diffthis, desc = "Diff current file" },
  { "<leader>gx", gitsigns.toggle_deleted, desc = "Toggle deleted" },
  -- show commit contains current position
  { "<leader>gc", "<cmd>lua require('xx.telescope').git_bcommits()<cr>", desc = "Current buffer commits" },
  { "<leader>gC", "<cmd>lua require('xx.telescope').git_commits()<cr>", desc = "All commits" },
  { "<leader>gB", "<cmd>lua require('xx.telescope').git_branches()<cr>", desc = "Branches" },
  { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
  { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
  {
    "<leader>gb",
    function()
      gitsigns.blame_line { full = true }
    end,
    desc = "Git blame for current hunk",
  },
  { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" },
  { "<leader>c", group = "change/command" },
  { "<leader>cb", gitsigns.toggle_current_line_blame, desc = "Toggle git blame for current line" },
  { "<leader>m", group = "mergetool/mark" },
  { "<leader>mb", "<cmd>call mergetool#toggle_layout('mr,b')<cr>", desc = "Toggle base" },
  { "<leader>mt", "<Plug>(MergetoolToggle)", desc = "Toggle mergetool" },
}

wk.add {
  mode = { "x" },
  { "ih", "<cmd>Gitsigns select_hunk<cr>", desc = "inner git hunk" },
  { "gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
}

-- navigate chunks of current buffer
wk.add {
  {
    "[c",
    function()
      if vim.o.diff then
        vim.cmd "normal! [c"
      else
        vim.cmd "Gitsigns prev_hunk"
      end
    end,
    desc = "Go to previous git hunk",
  },
  {
    "]c",
    function()
      if vim.o.diff then
        vim.cmd "normal! ]c"
      else
        vim.cmd "Gitsigns next_hunk"
      end
    end,
    desc = "Go to next git hunk",
  },
  { "[g", "<Plug>(MergetoolDiffExchangeLeft)", desc = "Push hunk to left" },
  { "]g", "<Plug>(MergetoolDiffExchangeRight)", desc = "Push hunk to right" },
}

local neogit_success, neogit = pcall(require, "neogit")
if not neogit_success then
  return
end
neogit.setup {
  disable_context_highlighting = false,
  signs = {
    section = { "", "" },
    item = { "", "" },
  },
  integrations = {
    diffview = true,
  },
}
