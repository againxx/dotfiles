if vim.fn.executable('nvr') > 0 then
  vim.fn.setenv('GIT_EDITOR', "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'")
end

local gs_success, gitsigns = pcall(require, 'gitsigns')
if not gs_success then
  return
end

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▒', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}


local wk_success, wk = pcall(require, 'which-key')
if not wk_success then
  return
end

wk.register({
  g = {
    name = '+git',
    a = { gitsigns.stage_hunk, 'Stage hunk' },
    u = { '<cmd>CocCommand git.chunkUndo<cr>', 'Undo chunk' },
    z = { '<cmd>CocCommand git.foldUnchanged<cr>', 'Fold unchanged' },
    r = { '<cmd>Git restore --staged %<Bar>CocCommand git.refresh<cr>', 'Restore current file' },
    -- show chunk diff at current position
    d = { gitsigns.preview_hunk, 'Hunk diff' },
    D = { gitsigns.diffthis, 'Diff current file' },
    -- show commit contains current position
    c = { '<Plug>(coc-git-commit)', 'Current line commits' },
    C = { "<cmd>lua require('xx.telescope').git_commits()<cr>", 'All commits' },
    ['<C-c>'] = { "<cmd>lua require('xx.telescope').git_bcommits()<cr>", 'Current buffer commits' },
    b = { "<cmd>lua require('xx.telescope').git_branches()<cr>", 'Branches' },
    s = { "<cmd>lua require('xx.telescope').git_status()<cr>", 'Status' },
  },
  ['<C-g>'] = { "<cmd>LazyGit<cr>", 'Lazygit' }
}, { prefix = '<leader>' })

-- navigate chunks of current buffer
wk.register({
    ['[g'] = { '<cmd>Gitsigns prev_hunk<cr>', 'Go to previous git hunk' },
    [']g'] = { '<cmd>Gitsigns next_hunk<cr>', 'Go to next git hunk' },
})
