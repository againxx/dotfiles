vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {
  {
    path = '~/Documents/Vimwiki/wiki',
    css_name = 'css/style.css',
    path_html = '~/Documents/Vimwiki/html',
    template_path = '~/Documents/Vimwiki/template',
    syntax = 'default',
    ext = '.wiki',
    links_space_char = '_',
    auto_tags = 1,
    auto_export = 1,
    nested_syntaxes = { python = 'python', cpp = 'cpp' }
  },
  {
    path = '~/Documents/Notes',
    syntax = 'markdown',
    ext = '.md',
    links_space_char = '_',
    auto_tags = 1
  },
}

vim.g.vimwiki_key_mappings = {
  table_format = 0,
  table_mappings = 0,
  lists_return = 0
}

vim.g.vimwiki_folding = 'expr'
-- vim.g.vimwiki_filetypes = ['markdown']
vim.g.vimwiki_table_auto_fmt = 0
vim.g.vimwiki_hl_headers = 1
vim.g.vimwiki_markdown_link_ext =1
vim.g.taskwiki_suppress_mappings = true

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
  s = 'Select and open wiki index',
}, { prefix = '<leader>w' })
