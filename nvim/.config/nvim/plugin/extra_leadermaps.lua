-- Functions

local query_syntax_stack = function()
  local _, line, col, _ = unpack(vim.fn.getpos ".")
  for _, id in ipairs(vim.fn.synstack(line, col)) do
    print(vim.fn.synIDattr(id, "name"))
  end
end

local tab_open_term = function(cmd)
  local cmd_name = cmd or vim.env.SHELL
  local cur_bufs = vim.api.nvim_list_bufs()
  local shell_buf = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" and vim.api.nvim_buf_get_name(buf):find(cmd_name)
  end, cur_bufs)
  if vim.tbl_isempty(shell_buf) then
    vim.cmd "tabnew"
    vim.g.shell_tab_num = vim.api.nvim_get_current_tabpage()
    if cmd then
      vim.cmd("terminal " .. cmd_name)
    else
      vim.cmd "terminal"
    end
    vim.g.shell_channel_id = vim.bo.channel
    vim.bo.buflisted = false
    vim.cmd "startinsert"
  else
    vim.cmd(vim.g.shell_tab_num .. "tabnext")
    if cmd then
      vim.cmd "startinsert"
    end
  end
end

-- echo different formats and the corresponding char for a given number
local echo_formats_and_char = function()
  local sel = table.concat(require("xx.utils").fetch_selection "v")
  local hex_regex = vim.regex [[\v\c^(\\x|0x|\\u|u\+)]]
  local dec_regex = vim.regex [[\v^\d+$]]
  local output
  if dec_regex:match_str(sel) then
    output = "0x" .. string.format("%x", sel)
  else -- hexdecimal
    local m_beg, m_end = hex_regex:match_str(sel)
    if m_beg then
      sel = "0x" .. sel:sub(m_end + 1)
      print(sel)
    else
      sel = "0x" .. sel
    end
    output = string.format("%d", sel)
  end
  local symbol = vim.fn.nr2char(output)
  vim.fn.setreg('"', symbol)
  print("<" .. sel .. "> " .. output .. " " .. symbol)
end

local execute_line = function()
  local line = vim.api.nvim_get_current_line()
  if vim.bo.filetype == "lua" then
    vim.cmd("lua " .. line)
  elseif vim.bo.filetype == "vim" then
    vim.cmd(line)
  end
end

local change_dir = function()
  local root_patterns = { ".vim", ".git" }
  local root_dir = require("xx.utils").find_bottom_up_project_root_dir(root_patterns)
  if root_dir then
    vim.cmd("lcd " .. root_dir)
    return
  end
  vim.cmd("lcd " .. vim.fn.expand "%:p:h")
end

-- neoscroll is not smooth over ssh, we may want to disable it temporarily
local disable_neoscroll = function()
  vim.keymap.del("n", "<C-u>")
  vim.keymap.del("n", "<C-d>")
  vim.keymap.del("n", "<C-y>")
  vim.keymap.del("n", "<C-e>")
  vim.keymap.del("n", "zt")
  vim.keymap.del("n", "zz")
  vim.keymap.del("n", "zb")
  _G.disable_neoscroll = true
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  { "<leader>q", group = "quit/close" },
  { "<leader>qb", "<cmd>silent! bdelete!<cr>", desc = "Close buffer" },
  { "<leader>qc", "<cmd>cclose<cr>", desc = "Close quickfix" },
  { "<leader>qd", "<cmd>let b:coc_diagnostic_disable = 1<Bar>edit<cr>", desc = "Close diagnostic" },
  { "<leader>qh", "<cmd>helpclose<cr>", desc = "Close help window" },
  { "<leader>ql", "<cmd>lclose<cr>", desc = "Close location list" },
  { "<leader>qt", "<cmd>tabclose<cr>", desc = "Close tab" },
  { "<leader>c", group = "change/command" },
  { "<leader>cD", "<cmd>execute 'lcd '.expand('%:p:h')<cr>", desc = "Change window directory to current directory" },
  { "<leader>cd", change_dir, desc = "Change window directory" },
  { "<leader>ci", "<cmd>IndentBlanklineToggle<cr>", desc = "Toggle indent line" },
  { "<leader>cs", disable_neoscroll, desc = "Disable neoscroll" },
  { "<leader>sH", query_syntax_stack, desc = "Syntax highlighting stack" },
  { "<leader>sT", "<cmd>terminal tokei<cr>", desc = "Tokei code statistic" },
  { "<leader>sc", "<cmd>lua require('persistence').load()<cr>", desc = "Restore session for current directory" },
  { "<leader>sf", "ga", desc = "Show different formats of character" },
  { "<leader>sh", "<cmd>Inspect<cr>", desc = "Syntax highlighting group" },
  { "<leader>sl", "<cmd>lua require('persistence').load({ last = true })<cr>", desc = "Restore last session" },
  { "<leader>sp", "<cmd>lua require('spectre').open_file_search()<cr>", desc = "Search and replace in current file" },
  { "<leader>st", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "TreeSitter highlighting under cursor" },
  {
    "<leader>sw",
    "<cmd>lua require('spectre').open_visual({select_word = true})<cr>",
    desc = "Search and replace current word",
  },
  { "<leader>n", group = "new" },
  { "<leader>nt", "<cmd>tabnew %<cr>", desc = "New tabpage" },
  { "<leader>nx", ":read !figlet<space>", desc = "Insert new figlet symbol" },
  {
    "<leader><C-t>",
    function()
      tab_open_term "vit"
    end,
    desc = "Open vit in new tab",
  },
  { "<leader>x", group = "execute/source" },
  { "<leader>xc", "<cmd>write<bar>source %<cr>", desc = "Source current file" },
  { "<leader>xl", execute_line, desc = "Execute current line as (Vim/Lua)" },
  {
    "<leader>xt",
    function()
      tab_open_term()
    end,
    desc = "Open terminal in new tab",
  },
  { "<leader>xv", "<cmd>source $MYVIMRC<Bar>nohlsearch<cr>", desc = "Source VIMRC" },
  {
    "<leader>yl",
    "<cmd>let @+=(expand('%:t') . ':' . nvim_win_get_cursor(0)[0])<cr>",
    desc = "Yank file path and line",
  },
  { "<leader>yp", "<cmd>let @+=expand('%:p')<cr>", desc = "Yank file path" },
  { "<leader>T", "<Plug>TranslateW", desc = "Translate" },
  { "<leader>S", "<cmd>lua require('spectre').open()<cr>", desc = "Search and replace" },
}

wk.add {
  mode = { "x" },
  { "<leader>S", "<cmd>lua require('spectre').open_visual()<cr>", desc = "Search and replace" },
  { "<leader>T", "<Plug>TranslateWV", desc = "Translate" },
  { "<leader>s", group = "show/search" },
  { "<leader>sf", echo_formats_and_char, desc = "Show different formats of character" },
  { "<leader>sw", "<cmd>lua require('spectre').open_visual()<cr>", desc = "Search and replace selected content" },
}

