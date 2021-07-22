local success, wk = pcall(require, 'which-key')
success = success and pcall(require, 'telescope')
if not success then
  return
end

wk.register({
  f = {
    name = '+find/file',
    f = { require('telescope.builtin').find_files, 'Files in current folder' },
    g = { require('telescope.builtin').git_files, 'Git files' },
    b = { require('telescope.builtin').buffers, 'Buffers' },
    h = { require('telescope.builtin').help_tags, 'Helps' },
    o = { require('xx.telescope').oldfiles, 'Recent files' },
    e = { require('xx.telescope').file_browser, 'File browser' },
    m = { require('xx.telescope').man_pages, 'Man pages' },
  },
  l = {
    name = '+list',
    l = { require('telescope.builtin').loclist, 'Open location list' },
    c = { require('telescope.builtin').quickfix, 'Open quickfix' },
  },
  o = {
    name = '+open/history',
    c = { require('telescope.builtin').command_history, 'Command history' },
    o = { require('xx.telescope').jumplist, 'Jump list' },
    m = { require('telescope.builtin').marks, 'Marks' },
    k = { require('telescope.builtin').keymaps, 'Key mappings' },
    u = { '<cmd>UndotreeToggle<cr>', 'Undo tree' },
    ['/'] = { require('telescope.builtin').search_history, 'Search history' },
  },
  p = { require('telescope.builtin').grep_string, 'Grep string' },
  s = {
    name = '+symbol/session/source/syntax',
    s = { require('xx.telescope').document_symbols, 'Document symbols' },
    a = { require('xx.telescope').workspace_symbols, 'Workspace symbols' },
    w = { '<cmd>CocCommand session.save<cr>', 'Save session' },
    r = { '<cmd>CocCommand session.load<cr>', 'Load session' },
    v = { '<cmd>source $MYVIMRC<Bar>nohlsearch<cr>', 'Source VIMRC' },
  },
  c = {
    c = { '<cmd>Telescope coc commands<cr>', 'Coc commands' },
    v = { require('telescope.builtin').commands, 'Vim commands' },
  },
}, { prefix = '<leader>' })

wk.register({
  ['<C-_>'] = {function() require('xx.telescope').current_buffer_fuzzy_find(vim.fn.expand('<cword>')) end, "Current buffer fuzzy find"},
  ['<C-p>'] = {require('telescope.builtin').live_grep, "Live grep"},
})

wk.register({
  p = { ":<c-u>lua require('xx.telescope').grep_selected()<cr>", 'Grep from selected' }
}, { mode = 'x', prefix = '<leader>' })
