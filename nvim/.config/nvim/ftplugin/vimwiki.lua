vim.opt_local.wrap = false
vim.opt_local.spell = true
-- Use vimwiki's folding method instead vim-markdown's
vim.g.vim_markdown_folding_disabled = true

-- vim-zettel
vim.g.zettel_format = "%title-%y%m%d"
vim.g.zettel_default_mappings = false
vim.g.zettel_fzf_options = { "--exact", "--tiebreak=end", "--preview-window=up:60%" }

-- taskwiki
vim.g.taskwiki_disable_concealcursor = true
vim.g.taskwiki_data_location = "~/Documents/tasks"

R "note.markdown_vimwiki"
require("plenary.filetype").add_file "extra_filetypes"
require "xx.cmp.vimwiki_tags"
require "xx.cmp.zi"
require("jieba-ci").init()

require("cmp").setup.buffer {
  sources = {
    { name = "luasnip" },
    { name = "vimwiki_tags" },
    { name = "katex" },
    { name = "buffer" },
    { name = "tmux" },
    {
      name = "zi",
      keyword_length = 3,
      option = {
        convert_case = true,
        loud = true,
        --dict = '/usr/share/dict/words'
      },
    },
  },
}

vim.cmd [[
  augroup vimwiki_special
    autocmd!
    autocmd User visual_multi_exit imap <buffer> <c-d> <Plug>VimwikiDecreaseLvlSingleItem
  augroup END
]]

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register({
  g = { "<cmd>VimwikiGenerateTagLinks<cr>", "Generate tag links" },
  b = { "<cmd>VimwikiBacklinks<cr>", "Search back links" },
  B = { "<cmd>ZettelBackLinks<cr>", "Generate back links" },
  a = { ":<c-u>ZettelNew ", "Add new wiki file" },
  i = { "<cmd>ZettelInsertNote<cr>", "Insert note" },
  f = { "<cmd>ZettelOpen<cr>", "Fuzzy find wiki file" },
  D = { "<Plug>VimwikiDeleteFile", "Delete current wiki file" },
  r = "Rename current wiki file",
  h = "Convert to html",
  c = "Colorize range of lines",
  hh = "Open html in browser",
  t = {
    name = "+tag",
    t = { "<cmd>execute 'VimwikiSearchTags '.expand('<cword>')<cr>", "Search tag under current cursor" },
    s = { ":<c-u>VimwikiSearchTags ", "Search tags" },
  },
  ["<leader>"] = {
    name = "+diary",
    w = "Open today diary",
    t = "Open today diary in new tab",
    y = "Open yesterday diary",
    m = "Open tomorrow diary",
    i = "Generate diary index",
  },
  ["<A-i>"] = { "<Plug>VimwikiNextLink", "Go to next link" },
  ["<A-o>"] = { "<Plug>VimwikiPrevLink", "Go to previous link" },
}, {
  prefix = "<leader>w",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  sa = { "<cmd>lua require('xx.telescope').tags()<cr>", "Fuzzy find tags" },
  t = {
    name = "+taskwiki",
    a = { "<cmd>TaskWikiAnnotate<cr>", "Annotate" },
    b = {
      name = "+burndown",
      d = { "<cmd>TaskWikiBurndownDaily<cr>", "Burndown daily" },
      w = { "<cmd>TaskWikiBurndownWeekly<cr>", "Burndown weekly" },
      m = { "<cmd>TaskWikiBurndownMonthly<cr>", "Burndown monthly" },
    },
    c = {
      name = "+choose",
      p = { "<cmd>TaskWikiChooseProject<cr>", "Choose project" },
      t = { "<cmd>TaskWikiChooseTag<cr>", "Choose tag" },
    },
    C = { "<cmd>TaskWikiCalendar<cr>", "Calendar" },
    d = { "<cmd>TaskWikiDone<cr>", "Done" },
    D = { "<cmd>TaskWikiDelete<cr>", "Delete" },
    e = { "<cmd>TaskWikiEdit<cr>", "Edit" },
    g = { "<cmd>TaskWikiGrid<cr>", "Grid" },
    G = {
      name = "+ghistory",
      m = { "<cmd>TaskWikiGhistoryMonthly<cr>", "Month ghistory" },
      a = { "<cmd>TaskWikiGhistoryAnnual<cr>", "Annual ghistory" },
    },
    h = {
      name = "+history",
      m = { "<cmd>TaskWikiHistoryMonthly<cr>", "Month history" },
      a = { "<cmd>TaskWikiHistoryAnnual<cr>", "Annual history" },
    },
    i = { "<cmd>TaskWikiInfo<cr>", "Info" },
    l = { "<cmd>TaskWikiLink<cr>", "Back link" },
    m = { "<cmd>TaskWikiMod<cr>", "Modify" },
    p = { "<cmd>TaskWikiProjects<cr>", "Projects" },
    s = { "<cmd>TaskWikiProjectsSummary<cr>", "Summary" },
    S = { "<cmd>TaskWikiStats<cr>", "Stats" },
    t = { "<cmd>TaskWikiTags<cr>", "Tags" },
    ["."] = { "<cmd>TaskWikiRedo<cr>", "Redo" },
    ["+"] = { "<cmd>TaskWikiStart<cr>", "Start" },
    ["-"] = { "<cmd>TaskWikiStop<cr>", "Stop" },
  },
}, {
  prefix = "<leader>",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  t = {
    name = "+taskwiki",
    a = { ":TaskWikiAnnotate<cr>", "Annotate" },
    c = {
      name = "+choose",
      p = { ":TaskWikiChooseProject<cr>", "Choose project" },
      t = { ":TaskWikiChooseTag<cr>", "Choose tag" },
    },
    d = { ":TaskWikiDone<cr>", "Done" },
    D = { ":TaskWikiDelete<cr>", "Delete" },
    e = { ":TaskWikiEdit<cr>", "Edit" },
    g = { ":TaskWikiGrid<cr>", "Grid" },
    i = { ":TaskWikiInfo<cr>", "Info" },
    l = { ":TaskWikiLink<cr>", "Back link" },
    m = { ":TaskWikiMod<cr>", "Modify" },
    ["."] = { ":TaskWikiRedo<cr>", "Redo" },
    ["+"] = { ":TaskWikiStart<cr>", "Start" },
    ["-"] = { ":TaskWikiStop<cr>", "Stop" },
  },
}, {
  mode = "v",
  prefix = "<leader>",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  l = {
    name = "+curent-list-item",
    t = { "<Plug>VimwikiRemoveSingleCB", "Remove checkbox from list item" },
    r = "Renumber list items",
    l = "Increase item level",
    h = "Decrease item level",
    n = "Increase done status",
    p = "Decrease done status",
    x = "Toggle checkbox disabled/off",
    ["*"] = "Add/change item symbol to *",
    ["-"] = "Add/change item symbol to -",
    ["1"] = "Add/change item symbol to 1",
  },
  L = {
    name = "+all-list-items",
    t = { "<Plug>VimwikiRemoveCBInList", "Remove checkbox from all sibling items" },
    r = "Renumber list items in whole file",
    R = "Renumber list items in whole file",
    l = "Increase list level and all children",
    L = "Increase list level and all children",
    h = "Decrease list level and all children",
    H = "Decrease list level and all children",
    ["*"] = "Change list symbol to *",
    ["-"] = "Change list symbol to -",
    ["1"] = "Change list symbol to number",
  },
}, {
  prefix = "g",
  buffer = vim.api.nvim_get_current_buf(),
})

if vim.fn.expand "%:e" == "wiki" then
  wk.register({
    b = { "**<Space><++><Esc>F*i", "Bold" },
    B = { "*__*<Space><++><Esc>F_i", "Bold italic" },
    d = { "~~~~<Space><++><Esc>F~hi", "Delete" },
    i = { "__<Space><++><Esc>F_i", "Italic" },
    C = { "{{{<CR>}}}<Esc>ka", "Code" },
    p = { "{{<bar><++>}}<Space><++><Esc>F{a", "Picture" },
    a = { "[[<bar><++>]]<Space><++><Esc>F[a", "Link" },
    r = { "==<Space>Reference<Space>==<CR><Esc>", "Reference" },
    M = { "{{$<CR>}}$<Esc>kA", "Math block" },
    ["1"] = { "=<Space><Space>=<Space><++><Esc>F=hi", "Header 1" },
    ["2"] = { "==<Space><Space>==<Space><++><Esc>F=2hi", "Header 2" },
    ["3"] = { "===<Space><Space>===<Space><++><Esc>F=3hi", "Header 3" },
    ["4"] = { "====<Space><Space>====<Space><++><Esc>F=4hi", "Header 4" },
    z = { "[[<esc><cmd>ZettelSearch<cr>", "Search link to insert" },
  }, {
    mode = "i",
    prefix = ";",
    buffer = vim.api.nvim_get_current_buf(),
  })
  wk.register({
    y = { "<Plug>ZettelYankNameMap", "Yank current zettel name and tile" },
    z = { "<Plug>ZettelReplaceFileWithLink", "Replace file with link" },
  }, {
    prefix = "g",
    buffer = vim.api.nvim_get_current_buf(),
  })
  wk.register({
    z = { "<Plug>ZettelNewSelectedMap", "Create new zettel from selected" },
  }, {
    mode = "x",
    prefix = "g",
    buffer = vim.api.nvim_get_current_buf(),
  })
end

vim.cmd [[hi! link Conceal Function]]
