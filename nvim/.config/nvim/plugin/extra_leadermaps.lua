-- Functions

local query_syntax_stack = function()
  local _, line, col, _ = unpack(vim.fn.getpos('.'))
  for _, id in ipairs(vim.fn.synstack(line, col)) do
    print(vim.fn.synIDattr(id, 'name'))
  end
end

local tab_open_term = function(cmd)
  local cmd_name = cmd or vim.env.SHELL
  local cur_bufs = vim.api.nvim_list_bufs()
  local shell_buf = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal'
      and vim.api.nvim_buf_get_name(buf):find(cmd_name)
  end, cur_bufs)
  if vim.tbl_isempty(shell_buf) then
    vim.cmd('tabnew')
    vim.g.shell_tab_num = vim.api.nvim_get_current_tabpage()
    if cmd then
      vim.cmd('terminal ' .. cmd_name)
    else
      vim.cmd('terminal')
    end
    vim.g.shell_channel_id = vim.bo.channel
    vim.bo.buflisted = false
    vim.cmd('startinsert')
  else
    vim.cmd(vim.g.shell_tab_num .. 'tabnext')
    if cmd then
      vim.cmd('startinsert')
    end
  end
end

-- echo different formats and the corresponding char for a given number
local echo_formats_and_char = function()
  local sel = table.concat(require('xx.utils').fetch_selection('v'))
  local hex_regex = vim.regex [[\v\c^(\\x|0x|\\u|u\+)]]
  local dec_regex = vim.regex [[\v^\d+$]]
  local output
  if dec_regex:match_str(sel) then
    output = '0x' .. string.format('%x', sel)
  else -- hexdecimal
    local m_beg, m_end = hex_regex:match_str(sel)
    if m_beg then
      sel = '0x' .. sel:sub(m_end + 1)
      print(sel)
    else
      sel = '0x' .. sel
    end
    output = string.format('%d', sel)
  end
  local symbol = vim.fn.nr2char(output)
  vim.fn.setreg('"', symbol)
  print('<' .. sel .. '> ' .. output .. ' ' .. symbol)
end

local execute_line = function()
  local line = vim.api.nvim_get_current_line()
  if vim.bo.filetype == 'lua' then
    vim.cmd('lua ' .. line)
  elseif vim.bo.filetype == 'vim' then
    vim.cmd(line)
  end
end

local change_dir = function()
  local root_patterns = { '.vim', '.git' }
  local root_dir = require('xx.utils').find_bottom_up_project_root_dir(root_patterns)
  if root_dir then
    vim.cmd('lcd ' .. root_dir)
    return
  end
  vim.cmd('lcd ' .. vim.fn.expand('%:p:h'))
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

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  q = {
    name = '+quit/close',
    b = { '<cmd>silent! bdelete!<cr>', 'Close buffer' },
    t = { '<cmd>tabclose<cr>', 'Close tab' },
    d = { '<cmd>let b:coc_diagnostic_disable = 1<Bar>edit<cr>', 'Close diagnostic' },
    c = { '<cmd>cclose<cr>', 'Close quickfix' },
    l = { '<cmd>lclose<cr>', 'Close location list' },
    h = { '<cmd>helpclose<cr>', 'Close help window' },
  },
  c = {
    name = '+change/command',
    d = { change_dir, 'Change window directory' },
    D = { "<cmd>execute 'lcd '.expand('%:p:h')<cr>", 'Change window directory to current directory' },
    i = { '<cmd>IndentBlanklineToggle<cr>', 'Toggle indent line' },
    s = { disable_neoscroll, 'Disable neoscroll' },
  },
  s = {
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", 'Syntax highlighting group' },
    H = { query_syntax_stack, 'Syntax highlighting stack' },
    t = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'TreeSitter highlighting under cursor' },
    T = { '<cmd>terminal tokei<cr>', 'Tokei code statistic' },
    f = { 'ga', 'Show different formats of character' },
    w = { "<cmd>lua require('spectre').open_visual({select_word = true})", 'Search and replace current word' },
    p = { "<cmd>lua require('spectre').open_file_search()", 'Search and replace in current file' },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", 'Restore last session' },
    c = { "<cmd>lua require('persistence').load()<cr>", 'Restore session for current directory' },
  },
  n = {
    name = '+new',
    t = { '<cmd>tabnew %<cr>', 'New tabpage' },
    x = { ':read !figlet<space>', 'Insert new figlet symbol' },
  },
  ['<C-t>'] = { function() tab_open_term('vit') end, 'Open vit in new tab' },
  x = {
    name = '+execute/source',
    t = { function() tab_open_term() end, 'Open terminal in new tab' },
    v = { '<cmd>source $MYVIMRC<Bar>nohlsearch<cr>', 'Source VIMRC' },
    c = { '<cmd>write<bar>source %<cr>', 'Source current file' },
    l = { execute_line, 'Execute current line as (Vim/Lua)' },
  },
  yp = { "<cmd>let @+=expand('%:p')<cr>", 'Yank file path' },
  yl = { "<cmd>let @+=(expand('%:t') . ':' . nvim_win_get_cursor(0)[0])<cr>", 'Yank file path and line' },
  T = { '<Plug>TranslateW', 'Translate' },
  S = { "<cmd>lua require('spectre').open()<cr>", 'Search and replace'}
}, { prefix = '<leader>' })

wk.register({
  s = {
    name = '+show',
    f = { echo_formats_and_char, 'Show different formats of character' }
  },
  T = { '<Plug>TranslateWV', 'Translate' },
  S = { "<cmd>lua require('spectre').open_visual()<cr>", 'Search and replace' },
}, { mode = 'x', prefix = '<leader>' })
