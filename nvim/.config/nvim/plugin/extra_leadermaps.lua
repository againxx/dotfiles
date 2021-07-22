-- Functions

local query_syntax_stack = function()
  local _, line, col, _ = unpack(vim.fn.getpos('.'))
  for _, id in ipairs(vim.fn.synstack(line, col)) do
    print(vim.fn.synIDattr(id, 'name'))
  end
end

-- local tab_open_term = function(cmd)
--   let command_name = a:0 > 0 ? a:1 : $SHELL
--   let shell_buffer = filter(range(1, bufnr('$')),
--   \   "getbufvar(v:val, '&buftype') ==# 'terminal' && bufname(v:val) =~# '" . command_name . "'")
--   if empty(shell_buffer)
--     tabnew
--     let g:shell_tab_num = tabpagenr()
--     if a:0 > 0
--       execute 'terminal' command_name
--     else
--       terminal
--     endif
--     let g:shell_channel_id = &channel
--     set nobuflisted
--     startinsert
--   else
--     execute g:shell_tab_num . 'tabnext'
--     if command_name ==# 'lazygit'
--       call chansend(g:shell_channel_id, "\<CR>")
--     endif
--     if command_name !=# $SHELL
--       startinsert
--     endif
--   endif
-- endfunction

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
    c = { '<cmd>lcd %:p:h<cr>', 'Change window directory' },
    i = { '<cmd>IndentBlanklineToggle<cr>', 'Toggle indent line' },
  },
  yp = { "<cmd>let @+=expand('%:p')<cr>", 'Yank file path' },
  s = {
    h = { vim.fn.SyntaxAttr, 'Syntax highlighting group' },
    H = { query_syntax_stack, 'Syntax highlighting stack' },
    t = { "<cmd>TSHighlightCapturesUnderCursor<cr>", 'TreeSitter highlighting under cursor' },
  }
}, { prefix = '<leader>' })

-- nnoremap <Leader><C-t> <Cmd>call OpenTerminal('vit')<CR>

-- " Terminal
-- nnoremap <Space>x <Cmd>call OpenTerminal()<CR>

