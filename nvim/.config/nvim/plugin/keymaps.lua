local keymap_opts = { silent = true }

vim.keymap.set("n", "n", function()
  local ok, result = pcall(vim.cmd, "normal! " .. vim.v.count1 .. "n")
  if not ok then
    vim.cmd(string.format("echo '%s'", string.match(result, "E%d+: .*$")))
  end
  require("hlslens").start()
end, keymap_opts)

vim.keymap.set("n", "N", function()
  local ok, result = pcall(vim.cmd, "normal! " .. vim.v.count1 .. "N")
  if not ok then
    vim.cmd(string.format("echo '%s'", string.match(result, "E%d+: .*$")))
  end
  require("hlslens").start()
end, keymap_opts)

vim.keymap.set("n", "*", [[*<cmd>lua require('hlslens').start()<cr>]], keymap_opts)
vim.keymap.set("n", "#", [[#<cmd>lua require('hlslens').start()<cr>]], keymap_opts)
vim.keymap.set("n", "g*", [[g*<cmd>lua require('hlslens').start()<cr>]], keymap_opts)
vim.keymap.set("n", "g#", [[g#<cmd>lua require('hlslens').start()<cr>]], keymap_opts)

local success, wk = pcall(require, "which-key")

if not success then
  return
end

local move_selected_lines = function(count)
  local srow = vim.fn.getpos("v")[2]
  local erow = vim.fn.getpos(".")[2]
  local crow = erow
  if srow > erow then
    srow, erow = erow, srow
  end
  local diff = (srow - erow) * count / math.abs(count)
  local range = srow .. "," .. erow
  if count == -1 then
    crow = srow - 2
  elseif count == 1 then
    crow = erow + 1
  elseif count < -1 then
    crow = crow + count - 1
  else
    crow = 2 * erow - crow + count
  end
  vim.cmd(range .. "move " .. crow)
  if count < 0 then
    crow = crow + 1
  end
  print(crow, diff)
  vim.api.nvim_feedkeys(crow .. "ggo" .. diff + crow .. "gg=gv", "n", false)
end

local add_empty_line = function(count)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local new_lines = {}
  for _ = 1, math.abs(count) do
    table.insert(new_lines, "")
  end
  if count < 0 then
    vim.api.nvim_put(new_lines, "l", false, false)
    cursor_pos[1] = cursor_pos[1] - count
  else
    vim.api.nvim_put(new_lines, "l", true, false)
  end
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

wk.add {
  { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign by motion" },
  { "gc", desc = "Linewise comment by motion" },
  { "gC", desc = "Toggle capslock" },
  { "gb", desc = "Blockwise comment by motion" },
  { "gus", "~", desc = "Switch case" },
  { "yp", '"+p', desc = "Paste system clipboard after cursor" },
  { "yP", '"+P', desc = "Paste system clipboard before cursor" },
  { "ZA", "<cmd>qa!<cr>", desc = "Quit all" },
  { "g[", desc = "reselect previously pasted text" },
  { "g*", desc = "Forward search word (without word boundary)" },
  { "g#", desc = "Backward search word (without word boundary)" },
  { "z;", "za", desc = "Toggle fold under cursor" },
  { "zV", "zczO", desc = "Open all folds under cursor" },
  { "[q", "<cmd>cfirst<cr>", desc = "Go to first quickfix term" },
  { "]q", "<cmd>clast<cr>", desc = "Go to last quickfix term" },
  { "[a", "<cmd>execute 'move -1-'.v:count1<cr>==", desc = "Move current line up" },
  { "]a", "<cmd>execute 'move +'.v:count1<cr>==", desc = "Move current line down" },
  { "[yp", "O<c-r>+<esc>", desc = "Paste system clipboard in new line above" },
  { "]yp", "o<c-r>+<esc>", desc = "Paste system clipboard in new line below" },
  {
    "[<space>",
    function()
      add_empty_line(-vim.v.count1)
    end,
    desc = "Add empty line above",
  },
  {
    "]<space>",
    function()
      add_empty_line(vim.v.count1)
    end,
    desc = "Add empty line below",
  },
}

wk.add {
  mode = { "x" },
  { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign for selected" },
  { "gc", desc = "Comment selected using linewise comment" },
  { "gb", desc = "Comment selected using blockwise comment" },
  {
    "[a",
    function()
      move_selected_lines(-vim.v.count1)
    end,
    desc = "Move selected line up",
  },
  {
    "]a",
    function()
      move_selected_lines(vim.v.count1)
    end,
    desc = "Move selected line down",
  },
}
