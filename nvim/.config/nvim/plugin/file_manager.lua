vim.g.coc_explorer_global_presets = {
  vimrc = {
    ['root-uri'] = '~/dotfiles/vim/vimrc',
    sources = {{ name = 'file', expand = true }}
  },
  dotfiles = {
    ['root-uri'] = '~/dotfiles',
    sources = {
      { name = 'buffer', expand = false },
      { name = 'file', expand = true }
    }
  },
  dictionaries = {
    ['root-uri'] = '~/dotfiles/vim/cSpell_dictionaries/',
    sources = {{ name = 'file', expand = true }}
  },
  tmuxp = {
    ['root-uri'] = '~/.config/tmuxp/',
    sources = {{ name = 'file', expand = true }}
  },
}

local open_coc_explorer = function(preset)
  require('bufferline.state').set_offset(40, '')
  if preset then
    if vim.tbl_contains(vim.g.coc_explorer_global_presets, preset) then
      vim.cmd('CocCommand explorer --preset ' .. preset)
    else
      vim.cmd('CocCommand explorer ' .. preset)
    end
  else
    vim.cmd('CocCommand explorer')
  end
end

local wk = require('which-key')

wk.register({
  e = {
    name = '+edit/explorer',
    s = { '<cmd>UltiSnipsEdit!<cr>', 'Edit snippets' },
    r = { '<cmd>AsyncTaskEdit<cr>', 'Edit local tasks' },
    R = { '<cmd>AsyncTaskEdit!<cr>', 'Edit global tasks' },
    t = { require('telescope_config').edit_tmuxp, 'Edit tmuxp configs' },
    T = { function() open_coc_explorer('tmuxp') end, 'Explore tmuxp config folder' },
    c = { function() open_coc_explorer(vim.fn.expand('%:p:h')) end, 'Explore current folder' },
    C = { '<cmd>CocLocalConfig<cr>', 'Edit coc local config' },
    m = { ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>", 'Edit macro / register' },
    e = { function() open_coc_explorer() end, 'Explore current git repo' },
    p = { require('telescope_config').edit_vim_plugins, 'Edit nvim plugin files' },
    v = { require('telescope_config').edit_vimrc, 'Edit nvim config' },
    V = { function() open_coc_explorer('vimrc') end, 'Explore nvim config folder' },
    d = { require('telescope_config').edit_dotfiles, 'Edit dotfiles' },
    D = { function() open_coc_explorer('dotfiles') end, 'Explore dotfile folder' },
    w = { require('telescope_config').edit_dictionaries, 'Edit cSpell dictionaries' },
    W = { function() open_coc_explorer('dictionaries') end, 'Explore cSpell dictionary folder' },
  },
  ra = { '<cmd>RnvimrToggle<cr>', 'Ranger' }
}, { prefix = '<leader>' })

-- rnvimr
-- Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_ex_enable = true
vim.g.rnvimr_layout = {
  relative = 'editor',
  width = math.ceil(0.8 * vim.o.columns),
  height = math.ceil(0.8 * vim.o.lines),
  col = math.floor(0.1 * vim.o.columns),
  row = math.floor(0.1 * vim.o.lines),
  style = 'minimal'
}
