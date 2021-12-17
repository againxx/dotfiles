vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. "/.local/share/nvim/site/pack/packer/start/vim-snippets/UltiSnips" }
vim.g.ulti_expand_res = 0
vim.g.ultisnips_python_quoting_style = 'double'
vim.g.ultisnips_python_triple_quoting_style = 'double'
vim.g.ultisnips_python_style = 'sphinx'
vim.g.ultisnips_cpp_style = 'google'

-- Use <C-l> to expand ultisnips or save visual selected content
vim.g.UltiSnipsExpandTrigger = '<C-l>'
-- Use <M-j> for jump to next placeholder and <M-k> for jump to previous placeholder
vim.g.coc_snippet_next = '<M-j>'
vim.g.coc_snippet_prev = '<M-k>'
vim.g.UltiSnipsJumpForwardTrigger = '<M-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<M-k>'
vim.g.UltiSnipsListSnippets = '<M-l>'

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  ['<leader>ls'] = { "<cmd>lua require('xx.telescope').ultisnips()<cr>", 'List available snippets' },
})
