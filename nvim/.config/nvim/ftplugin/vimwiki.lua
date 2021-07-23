local success, wk = pcall(require, 'which-key')
if not success then
  return
end

vim.opt_local.wrap = false
vim.b.coc_pairs_disabled = { '[', '<' }
-- Use vimwiki's folding method instead vim-markdown's
vim.g.vim_markdown_folding_disabled = true

require('plenary.filetype').add_file('extra_filetypes')

wk.register({
  g = { '<cmd>VimwikiGenerateTagLinks<cr>', 'Generate tag links' },
  b = { '<cmd>VimwikiBacklinks<cr>', 'Search back links' },
  B = { '<cmd>ZettelBackLinks<cr>', 'Generate back links' },
  a = { ':<c-u>ZettelNew ', 'Add new wiki file' },
  i = { '<cmd>ZettelInsertNote<cr>', 'Insert note' },
  f = { '<cmd>ZettelOpen', 'Fuzzy find wiki file' },
  D = { '<Plug>VimwikiDeleteFile', 'Delete current wiki file' },
  r = 'Rename current wiki file',
  h = 'Convert to html',
  c = 'Colorize range of lines',
  hh = 'Open html in browser',
  t = {
    name = '+tag',
    t = { "<cmd>execute 'VimwikiSearchTags '.expand('<cword>')<cr>", 'Search tag under current cursor' },
    s = { ':<c-u>VimwikiSearchTags ', 'Search tags' }
  }
}, { prefix = '<leader>w', buffer = vim.api.nvim_get_current_buf() })
