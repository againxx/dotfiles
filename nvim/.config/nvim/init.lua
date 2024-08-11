pcall(require, "impatient")
local fn = vim.fn

local lazypath = fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
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

require("lazy").setup {
  spec = "xx.plugins",
  concurrency = jit.os:find "OSX" and (vim.uv.available_parallelism() * 2) or nil,
}

require "xx.treesitter"
require "xx.globals"
