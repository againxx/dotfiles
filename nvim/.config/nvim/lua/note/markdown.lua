-- vim-markdown
vim.g.vim_markdown_math = true
vim.g.vim_markdown_folding_style_pythonic = true
vim.g.vim_markdown_new_list_item_indent = false

-- markdown-preview
vim.g.mkdp_refresh_slow = true
vim.g.mkdp_auto_close = false
vim.g.mkdp_preview_options = {
  katex = { fleqn = 1 },
}
vim.g.mkdp_markdown_css = vim.env.HOME .. '/dotfiles/custom_css/markdown/solarized-light.css'
vim.g.mkdp_highlight_css = vim.env.HOME .. '/dotfiles/custom_css/highlight/solarized-light.css'
