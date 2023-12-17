local opt = vim.opt

opt.hidden = true -- Allow buffer switch without saving
opt.lazyredraw = true
opt.cmdheight = 0
opt.showcmd = true -- Show (partial) command in status line
opt.showmatch = true -- Show matching brackets
opt.ignorecase = true -- Do case insensitive matching
opt.smartcase = true -- Do smart case matching
opt.hlsearch = true -- Highlight all search matches
opt.wildmenu = true
opt.wildmode = { 'longest', 'full' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- Ignore compiled files
opt.wildignore = { "*.o", "*~", "*.pyc", "*pycache*" }
opt.autoread = true
opt.showmode = false
opt.ruler = false
opt.number = true
opt.relativenumber = true
opt.backspace = { 'indent', 'eol', 'start' }
opt.smarttab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.splitright = true -- Prefer windows splitting to the right
opt.fillchars = { vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', horiz = '━', horizup = '┻', horizdown = '┳', diff = '' } -- ░▒▮▅╱▬

-- Use the symbols for tab and trailing spaces
opt.list = true
opt.listchars = { tab = ' ', trail = '▫' }

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = 'yes'
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 100
opt.timeoutlen = 500 -- Delay to show which-key
opt.shortmess:append('c') -- Don't pass messages to |ins-completion-menu|.
opt.modelines = 1
opt.scrolloff = 2
opt.cursorline = true
opt.mouse = 'a'
opt.showtabline = 2
opt.showbreak = '╰─▸ '
opt.diffopt:append('vertical')
opt.helplang = 'en'
opt.spelllang = { 'en_us', 'cjk' } -- to suppress warning for Chinese characters
opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'
-- Workaround for ghost highlight for blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
opt.colorcolumn = '99999'
opt.inccommand = 'split'
opt.undofile = true
opt.foldlevel = 1
opt.foldnestmax = 5
-- FastFold overwrites foldmethod to manual, in order to ensure saved
-- sessions do no save the default fold method to manual
opt.sessionoptions:remove('folds')
opt.sessionoptions:append('globals')
opt.swapfile = false -- lspsaga will generate error about too many swapfile

if not vim.env.KITTY_WINDOW_ID then
  opt.pumblend = 15
end

vim.g.sh_no_error = 1 -- Disable some error highlights for shell script
vim.g.is_bash = 1 --- Set bash as default shell script language
