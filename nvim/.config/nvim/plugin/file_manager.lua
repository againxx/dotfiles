vim.g.defx_icons_column_length = 2
vim.cmd [[
  command! -nargs=* DefxIcon execute 'Defx -columns=indent:icons:filename:type' expand('<args>')
]]

vim.g.defx_explorer_presets = {
  vimrc = {
    ['~/.config/nvim'] = true,
  },
  dotfiles = {
    ['~/dotfiles'] = true,
  },
  dictionaries = {
    ['~/dotfiles/vim/cSpell_dictionaries/'] = true,
  },
  tmuxp = {
    ['~/.config/tmuxp/'] = true,
  },
}

local open_defx_explorer = function(preset)
  vim.g.defx_open_in_vertical_split = true
  require('bufferline.state').set_offset(40, '')
  local common_args = "-split=vertical -winwidth=40 -direction=topleft"
  if preset then
    if vim.g.defx_explorer_presets[preset] then
      local preset_config = vim.g.defx_explorer_presets[preset]
      local cmd_args = { common_args }
      for opt, val in pairs(preset_config) do
        if type(val) ~= 'boolean' then
          table.insert(cmd_args, opt .. "=" .. val)
        else
          table.insert(cmd_args, opt)
        end
      end
      vim.cmd('DefxIcon ' .. table.concat(cmd_args, ' '))
    else
      vim.cmd(string.format('DefxIcon %s %s', common_args, preset))
    end
  else
    if vim.b.gitsigns_status_dict then
      vim.cmd(string.format('DefxIcon %s %s', common_args, vim.b.gitsigns_status_dict.root))
    else
      vim.cmd(string.format('DefxIcon %s', common_args))
    end
  end
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  e = {
    name = '+edit/explorer',
    r = { '<cmd>AsyncTaskEdit<cr>', 'Edit local tasks' },
    R = { '<cmd>AsyncTaskEdit!<cr>', 'Edit global tasks' },
    t = { "<cmd>lua require('xx.telescope').edit_tmuxp()<cr>", 'Edit tmuxp configs' },
    T = { function() open_defx_explorer('tmuxp') end, 'Explore tmuxp config folder' },
    c = { function() open_defx_explorer(vim.fn.expand('%:p:h')) end, 'Explore current folder' },
    m = { ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>", 'Edit macro / register' },
    e = { function() open_defx_explorer() end, 'Explore current git repo' },
    p = { "<cmd>lua require('xx.telescope').edit_vim_plugins()<cr>", 'Edit nvim plugin files' },
    v = { "<cmd>lua require('xx.telescope').edit_vimrc()<cr>", 'Edit nvim config' },
    V = { function() open_defx_explorer('vimrc') end, 'Explore nvim config folder' },
    d = { "<cmd>lua require('xx.telescope').edit_dotfiles()<cr>", 'Edit dotfiles' },
    D = { function() open_defx_explorer('dotfiles') end, 'Explore dotfile folder' },
    w = { "<cmd>lua require('xx.telescope').edit_dictionaries()<cr>", 'Edit cSpell dictionaries' },
    W = { function() open_defx_explorer('dictionaries') end, 'Explore cSpell dictionary folder' },
    h = { "<cmd>edit %:h<cr>", "Edit current file's directory" },
  },
  ra = { '<cmd>RnvimrToggle<cr>', 'Ranger' }
}, { prefix = '<leader>' })

-- rnvimr
-- Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_enable_ex = false
vim.g.rnvimr_layout = {
  relative = 'editor',
  width = math.ceil(0.8 * vim.o.columns),
  height = math.ceil(0.8 * vim.o.lines),
  col = math.floor(0.1 * vim.o.columns),
  row = math.floor(0.1 * vim.o.lines),
  style = 'minimal'
}
