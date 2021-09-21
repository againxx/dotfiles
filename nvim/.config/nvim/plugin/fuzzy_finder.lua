local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  f = {
    name = '+find/file',
    f = { "<cmd>lua require('xx.telescope').find_files()<cr>", 'Files in current folder' },
    g = { "<cmd>lua require('xx.telescope').git_files()<cr>", 'Git files' },
    b = { "<cmd>lua require('xx.telescope').buffers()<cr>", 'Buffers' },
    h = { "<cmd>lua require('xx.telescope').help_tags()<cr>", 'Helps' },
    o = { "<cmd>lua require('xx.telescope').oldfiles()<cr>", 'Recent files' },
    e = { "<cmd>lua require('xx.telescope').file_browser()<cr>", 'File browser' },
    m = { "<cmd>lua require('xx.telescope').man_pages()<cr>", 'Man pages' },
    p = { "<cmd>lua require('xx.telescope').projects()<cr>", 'Project files' },
    r = { "<cmd>lua require('xx.telescope').ros_workspace_packages()<cr>", 'Worksapce ros packages' },
    R = { "<cmd>lua require('xx.telescope').ros_core_packages()<cr>", 'Core ros packages' },
    ['/'] = { "<cmd>lua require('xx.telescope').grep_last_search()<cr>", 'Grep last search' },
  },
  l = {
    name = '+list',
    l = { '<cmd>LLToggle!<cr>', 'Toggle location list' },
    c = { '<cmd>QFToggle!<cr>', 'Toggle quickfix' },
    L = { "<cmd>lua require('xx.telescope').loclist()<cr>", 'Fuzzy find location list' },
    C = { "<cmd>lua require('xx.telescope').quickfix()<cr>", 'Fuzzy find quickfix' },
  },
  o = {
    name = '+open/history',
    c = { "<cmd>lua require('xx.telescope').command_history()<cr>", 'Command history' },
    o = { "<cmd>lua require('xx.telescope').jumplist()<cr>", 'Jump list' },
    m = { "<cmd>lua require('xx.telescope').marks()<cr>", 'Marks' },
    k = { "<cmd>lua require('xx.telescope').keymaps()<cr>", 'Key mappings' },
    u = { '<cmd>UndotreeToggle<cr>', 'Undo tree' },
    ['/'] = { "<cmd>lua require('xx.telescope').search_history()<cr>", 'Search history' },
  },
  p = { "<cmd>lua require('xx.telescope').grep_cursor_word()<cr>", 'Grep word under cursor' },
  P = { "<cmd>lua require('xx.telescope').grep_prompt()<cr>", 'Grep string with prompt' },
  s = {
    name = '+symbol/session/show',
    s = { "<cmd>lua require('xx.telescope').coc.document_symbols()<cr>", 'Document symbols' },
    a = { "<cmd>lua require('xx.telescope').coc..workspace_symbols()<cr>", 'Workspace symbols' },
  },
  c = {
    c = { "<cmd>lua require('xx.telescope').coc.commands()<cr>", 'Coc commands' },
    v = { "<cmd>lua require('xx.telescope').commands()<cr>", 'Vim commands' },
  },
}, { prefix = '<leader>' })

wk.register({
  ['<C-_>'] = { function() require('xx.telescope').current_buffer_fuzzy_find(vim.fn.expand('<cword>')) end, "Current buffer fuzzy find" },
  ['<C-p>'] = { "<cmd>lua require('xx.telescope').live_grep()<cr>", "Live grep" },
})

wk.register({
  p = { ":<c-u>lua require('xx.telescope').grep_selected()<cr>", 'Grep from selected' }
}, { mode = 'x', prefix = '<leader>' })
