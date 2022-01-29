vim.opt_local.iskeyword:append('92')
vim.opt_local.conceallevel = 2
vim.b.coc_additional_keywords = { '\\' }

if vim.b.match_words then
  vim.b.match_words = vim.b.match_words .. [[,\\begin{\w\+}:\\end{\w\+}]]
end

local switch_definitions = [==[
  let b:switch_custom_definitions = [
    {
      '\(|:\=-\+\)\+|': {
        '|\@<=-\(-\=|\)\@!': ':',
        '|\@<=[:-]\=-|\@=': ':-:',
        '\(|-\=\)\@<!-|\@=': ':',
      },
      '\(|:-\+:\)\+|': {
        '|\@<=:': '-'
      },
      '\(|-\+:\)\+|': {
        '|\@<=-': ':',
        ':|\@=': '-'
      },
      '!\@<!\[\([^]]\+\)\](\([^)]\+\))': '\[\[\2|\1\]\]',
      '\[\[\([^]|]\+\)|\([^]]\+\)\]\]': '\[\2\](\1)',
      '\[\[\([^]|]\+\)\]\]': '\[\1\](\1)',
      '^# \(.*\)$': '= \1 =',
      '^## \(.*\)$': '== \1 ==',
      '^### \(.*\)$': '=== \1 ===',
      '^#### \(.*\)$': '==== \1 ====',
      '^##### \(.*\)$': '===== \1 =====',
      '^###### \(.*\)$': '====== \1 ======',
      '^= \(.*\) =$': '# \1',
      '^== \(.*\) ==$': '## \1',
      '^=== \(.*\) ===$': '### \1',
      '^==== \(.*\) ====$': '#### \1',
      '^===== \(.*\) =====$': '##### \1',
      '^====== \(.*\) ======$': '###### \1',
      '{{\([^|]\+\)|\([^|]*\)|style="width:\(\d\+\)px"}}': '!\[\2\](\1 =\3x)',
      '!\[\([^]]*\)\](\([^)]\+\) =\(\d\+\)x)': '{{\2|\1|style="width:\3px"}}',
    },
    ['\\rightarrow', '\\longrightarrow', '\\Rightarrow', '\\Longrightarrow'],
    ['\\leftarrow', '\\longleftarrow', '\\Leftarrow', '\\Longleftarrow'],
    ['\\leftrightarrow', '\\longleftrightarrow', '\\Leftrightarrow', '\\Longleftrightarrow', '\\iff'],
    ['\\hat', '\\tilde', '\\widehat', '\\widetilde', '\\overline', '\\bar'],
    ['\\ldots', '\\cdots'],
    ['- [ ]', '- [X]']
  ]
]==]

vim.cmd(switch_definitions:gsub('\n', ''))

if vim.g.colors_name == 'ayu' then
  vim.cmd [[hi! link Conceal Function]]
  vim.cmd [[hi! link TaskwikiTaskPriority CocErrorSign]]
end

-- Table-mode
vim.g.table_mode_motion_left_map = '[t'
vim.g.table_mode_motion_right_map = ']t'
vim.g.table_mode_motion_up_map = '[T'
vim.g.table_mode_motion_down_map = ']T'
vim.g.table_mode_corner = '|'
vim.g.table_mode_map_prefix = '<localleader>t'
vim.g.table_mode_tableize_d_map = '<localleader>ta'

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  [';'] = {
    w = { '<Esc>/<++><CR>:nohlsearch<CR>"_cf>', 'Go to next word' },
    e = { '<Esc>/<Space>\\?<++><CR>:nohlsearch<CR>"_cf>', 'Go to end' },
    o = { '<Esc>/<Space>\\?<++><CR>:nohlsearch<CR>"_cf><CR>', 'Go to new line' },
    m = { '$$<++><C-o>F$', 'Inline math' },
    c = { '``<Space><++><C-o>F`', 'Emphasis' },
    t = { '-<Space>[<Space>]<Space>', 'Check list' },
    T = { '*<Space>[<Space>]<Space>', 'Task list' },
    n = { [[<Esc>A<Space>\\<CR>]], 'New line in math block' },
    q = { '<Esc>/[)}\\]]<CR>:nohlsearch<CR>a', 'Go out of )}]' },
    [';'] = { ';', 'Literal ;' },
    -- when packer first load TableMode the TableModeEnable command does not have effect,
    -- the cursor will also jump to some strange place, use `. to jump to the original place
    ['|'] = { '<cmd>TableModeEnable<cr><cmd>TableModeEnable<cr><c-o>`.| ', 'Toggle table mode' },
  },
}, { mode = 'i', buffer = vim.api.nvim_get_current_buf() })

wk.register({
  K = { '<Plug>(coc-translator-p)', 'Translate' },
  ['<space><space>'] = { '/<++><cr>:nohlsearch<cr>"_c4l', 'Go to next anchor' },
  ['[t'] = 'Go to left table cell',
  [']t'] = 'Go to right table cell',
  ['[T'] = 'Go to up table cell',
  [']T'] = 'Go to down table cell',
}, { buffer = vim.api.nvim_get_current_buf() })

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
