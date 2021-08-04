local success, wk = pcall(require, 'which-key')
if not success then
  return
end

vim.opt_local.colorcolumn = ''

wk.register({
  ['<A-i>'] = { [[<cmd>call search('<Bar>.\{-}<Bar>', 'w')<cr>]], 'Go to next tag' },
  ['<A-o>'] = { [[<cmd>call search('<Bar>.\{-}<Bar>', 'wb')<cr>]], 'Go to previous tag' },
  [']t'] = { [[<cmd>call search('<Bar>.\{-}<Bar>', 'w')<cr>]], 'Go to next tag' },
  ['[t'] = { [[<cmd>call search('<Bar>.\{-}<Bar>', 'wb')<cr>]], 'Go to previous tag' }
}, { buffer = vim.api.nvim_get_current_buf() })
