-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ustc-1314/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/ustc-1314/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/ustc-1314/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/ustc-1314/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ustc-1314/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  FastFold = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/FastFold"
  },
  ["SyntaxAttr.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/SyntaxAttr.vim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/asynctasks.vim"
  },
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["comfortable-motion.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/comfortable-motion.vim"
  },
  firenvim = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  fzf = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/fzf"
  },
  ["fzf.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  ["incsearch-fuzzy.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/incsearch-fuzzy.vim"
  },
  ["incsearch.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/incsearch.vim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["info.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/info.vim"
  },
  ["jupytext.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/jupytext.vim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["nvim-terminal.lua"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plantuml-syntax"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/plantuml-syntax"
  },
  playground = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["python-syntax"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/python-syntax"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  rainbow = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["rename.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/rename.vim"
  },
  rnvimr = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/switch.vim"
  },
  tabular = {
    after_files = { "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/tabular/after/plugin/TabularMaps.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/tabular"
  },
  taskwiki = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/taskwiki"
  },
  ["telescope-asynctasks.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope-asynctasks.nvim"
  },
  ["telescope-coc.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope-coc.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-ros.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope-ros.nvim"
  },
  ["telescope-ultisnips.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope-ultisnips.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tmux-complete.vim"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/tmux-complete.vim"
  },
  ["tmuxline.vim"] = {
    commands = { "Tmuxline", "TmuxlineSnapshot" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/tmuxline.vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "\27LJ\1\2(\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\rundotree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-barbaric"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-barbaric"
  },
  ["vim-be-good"] = {
    commands = { "VimBeGood" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-be-good"
  },
  ["vim-capslock"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-capslock"
  },
  ["vim-cmake-syntax"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-cmake-syntax"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cppman"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-cppman"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gas"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-gas"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-jsonc"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-jsonc"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-maximizer"] = {
    commands = { "MaximizerToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-maximizer"
  },
  ["vim-numbertoggle"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-numbertoggle"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-searchlight"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-searchlight"
  },
  ["vim-slime"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-slime"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-superman"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-superman"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-table-mode"] = {
    commands = { "TableModeToggle", "TableModeEnable" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-table-mode"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-valgrind"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-valgrind"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-zettel"] = {
    config = { "\27LJ\1\2#\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\bfzf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-zettel"
  },
  vimspector = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vimspector"
  },
  vimwiki = {
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/ustc-1314/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\1\2;\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":TableModeToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file TableModeToggle lua require("packer.load")({'vim-table-mode'}, { cmd = "TableModeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":TableModeEnable") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file TableModeEnable lua require("packer.load")({'vim-table-mode'}, { cmd = "TableModeEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":VimBeGood") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file VimBeGood lua require("packer.load")({'vim-be-good'}, { cmd = "VimBeGood", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":MaximizerToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file MaximizerToggle lua require("packer.load")({'vim-maximizer'}, { cmd = "MaximizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":UndotreeToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Tmuxline") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Tmuxline lua require("packer.load")({'tmuxline.vim'}, { cmd = "Tmuxline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":TmuxlineSnapshot") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file TmuxlineSnapshot lua require("packer.load")({'tmuxline.vim'}, { cmd = "TmuxlineSnapshot", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType python ++once lua require("packer.load")({'FastFold'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'markdown-preview.nvim', 'vim-barbaric', 'tabular'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vimwiki ++once lua require("packer.load")({'vim-zettel', 'fzf.vim', 'fzf', 'vim-barbaric'}, { ft = "vimwiki" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/ustc-1314/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
