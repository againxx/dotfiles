vim.g.ulti_expand_res = 0
vim.g.ultisnips_python_quoting_style = 'double'
vim.g.ultisnips_python_triple_quoting_style = 'double'
vim.g.ultisnips_python_style = 'sphinx'
vim.g.ultisnips_cpp_style = 'google'

-- Use <C-l> to expand ultisnips or save visual selected content
vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<M-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<M-k>'
vim.g.UltiSnipsListSnippets = '<M-l>'

-- neovim bug that doesn't specify noautocmd: true for making floating window options
-- https://github.com/ray-x/lsp_signature.nvim/issues/143
local old_make_floating = vim.lsp.util.make_floating_popup_options
if not old_make_floating(0, 0, {}).noautocmd then
    vim.lsp.util.make_floating_popup_options = function(width, height, opts)
        local ret = old_make_floating(width, height, opts)
        ret.noautocmd = true
        return ret
    end
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  ['<leader>ls'] = { "<cmd>lua require('xx.telescope').ultisnips()<cr>", 'List available snippets' },
})
