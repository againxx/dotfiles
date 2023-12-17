pcall(require, "impatient")
local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- speed up
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.node_host_prog = "~/.config/yarn/global/node_modules/neovim/bin/cli.js"
vim.g.loaded_python_provider = 0 -- disable python 2 support
vim.g.loaded_perl_provider = 0 -- disable perl support
vim.g.loaded_ruby_provider = 0 -- disable ruby support
vim.opt.termguicolors = true

require("lazy").setup("xx.plugins")

require "xx.treesitter"
require "xx.globals"
