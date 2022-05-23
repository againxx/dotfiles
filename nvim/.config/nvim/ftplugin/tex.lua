vim.g.vimtex_quickfix_mode = 0

vim.api.nvim_buf_set_keymap(0, '', 'K', '<Plug>(vimtex-doc-package)', { noremap = false })

require('cmp').setup.buffer {
  formatting = {
    format = function(entry, vim_item)
        vim_item.menu = ({
          omni = (vim.inspect(vim_item.menu):gsub('%"', ""):gsub("cmd: default", "tex")),
          buffer = "[buf]",
          })[entry.source.name]
        return vim_item
      end,
  },
  sources = {
    { name = 'omni' },
    {
      name = "look",
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true,
      },
    },
    { name = "luasnip" },
    { name = 'buffer' },
  },
}

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register({
  name = "+latex",
  i = { "Information about current project" },
  I = { "Information about all projects" },
  t = { "Open table of contents" },
  T = { "Toggle table of contents" },
  q = { "Show message log" },
  v = { "View pdf" },
  r = { "Reverse search" },
  l = { "Toggle compiler" },
  L = { "Compile selected part" },
  k = { "Stop compilation" },
  K = { "Stop compilation of all projects" },
  e = { "Open quickfix for errors/warnings" },
  o = { "Open file redirected by compiler output" },
  g = { "Show compilation status" },
  G = { "Show compilation status for all projects" },
  c = { "Clean auxiliary files" },
  C = { "Clean auxiliary/output files" },
  m = { "Show list of insert mappings" },
  x = { "Reload VimTeX scripts" },
  X = { "Reload state for current buffer" },
  s = { "Toggle main file" },
  a = { "Show context menu" },
}, {
  prefix = "<localleader>l",
  buffer = vim.api.nvim_get_current_buf(),
})

wk.register({
  name = "+latex",
  L = { "Compiler" },
}, {
  mode = "x",
  prefix = "<localleader>l",
  buffer = vim.api.nvim_get_current_buf(),
})

-- add $ into autopairs
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("$","$","tex"):with_move(function(opts)
  if opts.char == "$" then
    return true
  end
  return false
end))
