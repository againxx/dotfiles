require('impatient')
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
  require('xx.plugins')
  require('packer').install()
  return
end

vim.g.mapleader = ' '
vim.g.maplocalleader = '-'

-- speed up
vim.g.python3_host_prog  = '/usr/bin/python3'
vim.g.node_host_prog = '~/.config/yarn/global/node_modules/neovim/bin/cli.js'
vim.g.loaded_python_provider = 0 -- disable python 2 support
vim.g.loaded_perl_provider = 0 -- disable perl support
vim.g.loaded_ruby_provider = 0 -- disable ruby support
vim.g.do_filetype_lua = 1

require('xx.treesitter')
require('xx.globals')
