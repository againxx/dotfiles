vim.g.VM_set_statusline = 2
vim.g.VM_silent_exit = true
vim.g.VM_quit_after_leaving_insert_mode = true

vim.g.VM_leader = '<Leader>v'
vim.g.VM_maps = {
  ['Add Cursor Down'] = '<Leader>vj',
  ['Add Cursor Up'] = '<Leader>vk',
  ['Select l'] = '<Leader>vl',
  ['Select h'] = '<Leader>vh',
  ['Reselect Last'] = '<Leader>v.',
  ['Toggle Mappings'] = '<Leader>v;',
  ['Run Visual'] = '<Leader>v<C-v>',
  ['Add Cursor At Pos'] = '<Leader>vv',
  ['Move Right'] = '<M-S-l>',
  ['Move Left'] = '<M-S-h>',
}

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  name = '+multi-cursors',
  a = 'Align cursor',
  A = 'Select all',
  s = 'Split region',
  v = 'Add cursor at current position',
  j = 'Add cursor down',
  k = 'Add cursor up',
  h = 'Select left',
  l = 'Select right',
  c = 'Case setting',
  C = 'Case conversion menu',
  n = 'Append numbers',
  N = 'Prepend numbers',
  z = 'Run normal command',
  Z = 'Run last normal command',
  V = 'Run last visual command',
  ['<C-v>'] = 'Run visual command',
  ['@'] = 'Run macro',
  ['<'] = 'Align by character',
  ['>'] = 'Align by regex',
  ['/'] = 'Regex search',
  [';'] = 'Toggle mappings',
  ['.'] = 'Reselect last',
  ['`'] = 'Tools menu',
  ['"'] = 'Show registers',
  ['<cr>'] = 'Toggle single region',
  ['<C-a>'] = 'Increase alphabet',
  ['<C-x>'] = 'Decrease alphabet',
}, { prefix = '<leader>v' })
