local wk = require('which-key')

wk.register({
  f = {
    name = '+find/file',
    f = { require('telescope.builtin').find_files, 'Files in current folder' },
    g = { require('telescope.builtin').git_files, 'Git files' },
    b = { require('telescope.builtin').buffers, 'Buffers' },
    h = { require('telescope.builtin').help_tags, 'Helps' },
    o = { require('telescope_config').oldfiles, 'Recent files' },
    e = { require('telescope_config').file_browser, 'File browser' },
    m = { require('telescope_config').man_pages, 'Man pages' },
  },
  l = {
    name = '+list',
    l = { require('telescope.builtin').loclist, 'Open location list' },
    c = { require('telescope.builtin').quickfix, 'Open quickfix' },
  },
  o = {
    name = '+open/history',
    c = { require('telescope.builtin').command_history, 'Command history' },
    o = { require('telescope_config').jumplist, 'Jump list' },
    m = { require('telescope.builtin').marks, 'Marks' },
    k = { require('telescope.builtin').keymaps, 'Key mappings' },
    u = { '<cmd>UndotreeToggle<cr>', 'Undo tree' },
    ['/'] = { require('telescope.builtin').search_history, 'Search history' },
  },
  p = { require('telescope.builtin').grep_string, 'Grep string' },
  s = {
    name = '+symbol/session/source',
    s = { require('telescope_config').document_symbols, 'Document symbols' },
    a = { require('telescope_config').workspace_symbols, 'Workspace symbols' },
    w = { '<cmd>CocCommand session.save<cr>', 'Save session' },
    r = { '<cmd>CocCommand session.load<cr>', 'Load session' },
    v = { '<cmd>source $MYVIMRC<Bar>nohlsearch<cr>', 'Source VIMRC' },
  },
  q = {
    name = '+quit/close',
    b = { '<cmd>silent! bdelete!<cr>', 'Close buffer' },
    w = { '<cmd>silent! bwipeout!<cr>', 'Wipeout buffer' },
    t = { '<cmd>tabclose<cr>', 'Close tab' },
    d = { '<cmd>let b:coc_diagnostic_disable = 1<Bar>edit<cr>', 'Close diagnostic' },
    c = { '<cmd>cclose<cr>', 'Close quickfix' },
    l = { '<cmd>lclose<cr>', 'Close location list' },
  }
}, { prefix = '<leader>' })

wk.register({
  ['<C-_>'] = {function() require('telescope_config').current_buffer_fuzzy_find(vim.fn.expand('<cword>')) end, "Current buffer fuzzy find"},
  ['<C-p>'] = {require('telescope.builtin').live_grep, "Live grep"},
})

wk.register({
  p = { ":<c-u>lua require('telescope_config').grep_selected()<cr>", 'Grep from selected' }
}, { mode = 'x', prefix = '<leader>' })
