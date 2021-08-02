if vim.fn.executable('nvr') > 0 then
  vim.fn.setenv('GIT_EDITOR', "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'")
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  g = {
    name = '+git',
    a = { '<cmd>CocCommand git.chunkStage<cr>', 'Stage chunk' },
    u = { '<cmd>CocCommand git.chunkUndo<cr>', 'Undo chunk' },
    z = { '<cmd>CocCommand git.foldUnchanged<cr>', 'Fold unchanged' },
    r = { '<cmd>Git restore --staged %<Bar>CocCommand git.refresh<cr>', 'Restore current file' },
    -- show chunk diff at current position
    d = { '<Plug>(coc-git-chunkinfo)', 'Chunk diff' },
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
    ['[g'] = { '<Plug>(coc-git-prevchunk)', 'Go to previous git chunk' },
    [']g'] = { '<Plug>(coc-git-nextchunk)', 'Go to next git chunk' },
})
