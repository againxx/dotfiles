vim.opt_local.iskeyword:append('92')
vim.opt_local.conceallevel = 2
vim.b.coc_additional_keywords = { '\\' }

if vim.b.match_words then
  vim.b.match_words = vim.b.match_words .. [[,\\begin{\w\+}:\\end{\w\+}]]
end

vim.cmd [[let b:switch_custom_definitions = markdown_vimwiki#custom_switches]]

if vim.g.colors_name == 'ayu' then
  vim.cmd [[hi! link Conceal Function]]
  vim.cmd [[hi! link TaskwikiTaskPriority CocErrorSign]]
end

-- Table-mode
vim.g.table_mode_motion_left_map = '[t'
vim.g.table_mode_motion_right_map = ']t'
vim.g.table_mode_motion_up_map = '[T'
vim.g.table_mode_motion_down_map = ']T'

-- Use w/b to move over chinese ci
vim.api.nvim_buf_set_keymap(0, 'n', 'w', '<Plug>(coc-ci-w)', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', 'b', '<Plug>(coc-ci-b)', { silent = true })

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  [';'] = {
    w = { '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', 'Go to next word' },
    e = { '<Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l', 'Go to end' },
    o = { '<Esc>/<Space><++><CR>:nohlsearch<CR>"_c5l<CR>', 'Go to new line' },
    m = { '$$<++><C-o>F$', 'Inline math' },
    c = { '``<Space><++><C-o>F`', 'Emphasis' },
    t = { '-<Space>[<Space>]<Space>', 'Check list' },
    T = { '*<Space>[<Space>]<Space>', 'Task list' },
    n = { '<Esc>A<Space>\\<CR>', 'New line in math block' },
    q = { '<Esc>/[)}\\]]<CR>:nohlsearch<CR>a', 'Go out of )}]' },
    [';'] = { ';', 'Literal ;' },
  },
}, { mode = 'i', buffer = vim.api.nvim_get_current_buf() })

wk.register({
  ['<space><space>'] = { '/<++><cr>:nohlsearch<cr>"_c4l', 'Go to next anchor' },
  ['[t'] = 'Go to left table cell',
  [']t'] = 'Go to right table cell',
  ['[T'] = 'Go to up table cell',
  [']T'] = 'Go to down table cell',
}, { buffer = vim.api.nvim_get_current_buf() })

-- Table-mode
vim.g.table_mode_corner = '|'
vim.g.table_mode_map_prefix = '<localleader>t'
vim.g.table_mode_tableize_d_map = '<localleader>ta'
wk.register({
  t = {
    name = '+table',
    m = { '<cmd>TableModeToggle<cr>', 'Toggle table mode' },
    r = 'Table realign',
    a = 'Tableize',
    dd = 'Delete row',
    dc = 'Delete column',
    ['?'] = 'Cell representation',
  }
}, { prefix = '<localleader>', buffer = vim.api.nvim_get_current_buf() })
