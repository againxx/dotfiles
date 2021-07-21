local wk = require('which-key')

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
    C = { require('telescope.builtin').git_commits, 'All commits' },
    ['<C-c>'] = { require('telescope_config').git_bcommits, 'Current buffer commits' },
    b = { require('telescope.builtin').git_branches, 'Branches' },
    s = { require('telescope.builtin').git_status, 'Status' },
  },
  ['<C-g>'] = { "<cmd>LazyGit<cr>", 'Lazygit' }
}, { prefix = '<leader>' })

-- navigate chunks of current buffer
wk.register({
    ['[g'] = { '<Plug>(coc-git-prevchunk)', 'Go to previous git chunk' },
    [']g'] = { '<Plug>(coc-git-nextchunk)', 'Go to next git chunk' },
})

if vim.fn.executable('nvr') > 0 then
  vim.fn.setenv('GIT_EDITOR', "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'")
end
