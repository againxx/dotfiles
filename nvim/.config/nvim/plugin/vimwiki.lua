local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  name = '+wiki',
  w = { ":<c-u>VimwikiIndex<cr>:lcd %:p:h<cr>:lua require('xx.telescope').find_files()<cr>", 'Open default wiki index' },
  n = { '<cmd>VimwikiIndex 2<cr>', 'Open notes index' },
  d = { '<Plug>VimwikiDiaryIndex', 'Open diary index' },
  T = { '<Plug>VimwikiTabIndex', 'Open default index in new tab' },
}, { prefix = '<leader>w' })
