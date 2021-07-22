-- Functions

local query_syntax_stack = function()
  local _, line, col, _ = unpack(vim.fn.getpos('.'))
  for _, id in ipairs(vim.fn.synstack(line, col)) do
    print(vim.fn.synIDattr(id, 'name'))
  end
end

local tab_open_term = function(cmd)
  local cmd_name = cmd or os.getenv('SHELL')
  local cur_bufs = vim.api.nvim_list_bufs()
  local shell_buf = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal'
      and vim.api.nvim_buf_get_name(buf):find(cmd_name)
  end, cur_bufs)
  if #shell_buf == 0 then
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

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  q = {
    name = '+quit/close',
    b = { '<cmd>silent! bdelete!<cr>', 'Close buffer' },
    w = { '<cmd>silent! bwipeout!<cr>', 'Wipeout buffer' },
    t = { '<cmd>tabclose<cr>', 'Close tab' },
    d = { '<cmd>let b:coc_diagnostic_disable = 1<Bar>edit<cr>', 'Close diagnostic' },
    c = { '<cmd>cclose<cr>', 'Close quickfix' },
    l = { '<cmd>lclose<cr>', 'Close location list' },
  },
  c = {
    name = '+change/command',
    d = { '<cmd>lcd %:p:h<cr>', 'Change window directory' },
    i = { '<cmd>IndentBlanklineToggle<cr>', 'Toggle indent line' },
  },
  yp = { "<cmd>let @+=expand('%:p')<cr>", 'Yank file path' },
  s = {
    h = { vim.fn.SyntaxAttr, 'Syntax highlighting group' },
    H = { query_syntax_stack, 'Syntax highlighting stack' },
    t = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'TreeSitter highlighting under cursor' },
  },
  ['<C-t>'] = { function() tab_open_term('vit') end, 'Open vit in new tab' },
  x = { function() tab_open_term() end, 'Open terminal in new tab' },
}, { prefix = '<leader>' })
