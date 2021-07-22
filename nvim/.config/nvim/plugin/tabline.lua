vim.cmd [[
  nnoremap <A-,> <cmd>BufferPrevious<cr>
  nnoremap <A-.> <cmd>BufferNext<cr>
  nnoremap <A-<> <cmd>BufferMovePrevious<cr>
  nnoremap <A->> <cmd>BufferMoveNext<cr>
  nnoremap <A-1> <cmd>BufferGoto 1<cr>
  nnoremap <A-2> <cmd>BufferGoto 2<cr>
  nnoremap <A-3> <cmd>BufferGoto 3<cr>
  nnoremap <A-4> <cmd>BufferGoto 4<cr>
  nnoremap <A-5> <cmd>BufferGoto 5<cr>
  nnoremap <A-6> <cmd>BufferGoto 6<cr>
]]

vim.g.bufferline = {
  closable = false,
  maximum_padding = 1,
  icon_separator_active = '▊'
}

local close_qf_first = function ()
  local quickfix_win = vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')
  if vim.fn.empty(quickfix_win) == 0 then
    vim.cmd('cclose')
    vim.cmd('lclose')
  else
    vim.cmd('BufferClose')
  end
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  ['[b'] = { '<cmd>BufferGoto 1<cr>', 'Go to first buffer' },
  [']b'] = { '<cmd>BufferLast<cr>', 'Go to last buffer' },
  ['<leader>qq'] = { close_qf_first, 'Only close buffer' },
  ['<leader>qa'] = { '<cmd>BufferCloseAllButCurrent<cr>', 'Only all buffer but current' },
  ['<leader>b'] = {
    name = '+buffer',
    b = { '<cmd>BufferPick<cr>', 'Pick buffer' },
    -- sort automatically by
    d = { '<cmd>BufferOrderByDirectory<cr>', 'Sort buffer by directory' },
    l = { '<cmd>BufferOrderByLanguage<cr>', 'Sort buffer by language' },
  }
})
