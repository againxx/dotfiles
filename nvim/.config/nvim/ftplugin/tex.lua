require("jieba-ci").init()
vim.g.vimtex_quickfix_mode = 0

vim.api.nvim_buf_set_keymap(0, "", "K", "<Plug>(vimtex-doc-package)", { noremap = false })

require("cmp").setup.buffer {
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
    { name = "omni" },
    {
      name = "look",
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true,
      },
    },
    { name = "luasnip" },
    { name = "buffer" },
  },
}

local success, wk = pcall(require, "which-key")
if not success then
  return
end

local bufnr = vim.api.nvim_get_current_buf()

wk.add {
  { "<localleader>l", buffer = bufnr, group = "latex" },
  { "<localleader>lC", buffer = bufnr, desc = "Clean auxiliary/output files" },
  { "<localleader>lG", buffer = bufnr, desc = "Show compilation status for all projects" },
  { "<localleader>lI", buffer = bufnr, desc = "Information about all projects" },
  { "<localleader>lK", buffer = bufnr, desc = "Stop compilation of all projects" },
  { "<localleader>lL", buffer = bufnr, desc = "Compile selected part" },
  { "<localleader>lT", buffer = bufnr, desc = "Toggle table of contents" },
  { "<localleader>lX", buffer = bufnr, desc = "Reload state for current buffer" },
  { "<localleader>la", buffer = bufnr, desc = "Show context menu" },
  { "<localleader>lc", buffer = bufnr, desc = "Clean auxiliary files" },
  { "<localleader>le", buffer = bufnr, desc = "Open quickfix for errors/warnings" },
  { "<localleader>lg", buffer = bufnr, desc = "Show compilation status" },
  { "<localleader>li", buffer = bufnr, desc = "Information about current project" },
  { "<localleader>lk", buffer = bufnr, desc = "Stop compilation" },
  { "<localleader>ll", buffer = bufnr, desc = "Toggle compiler" },
  { "<localleader>lm", buffer = bufnr, desc = "Show list of insert mappings" },
  { "<localleader>lo", buffer = bufnr, desc = "Open file redirected by compiler output" },
  { "<localleader>lq", buffer = bufnr, desc = "Show message log" },
  { "<localleader>lr", buffer = bufnr, desc = "Reverse search" },
  { "<localleader>ls", buffer = bufnr, desc = "Toggle main file" },
  { "<localleader>lt", buffer = bufnr, desc = "Open table of contents" },
  { "<localleader>lv", buffer = bufnr, desc = "View pdf" },
  { "<localleader>lx", buffer = bufnr, desc = "Reload VimTeX scripts" },
  { "<localleader>l", buffer = bufnr, group = "latex", mode = "x" },
  { "<localleader>lL", buffer = bufnr, desc = "Compiler", mode = "x" },
}

-- add $ into autopairs
local Rule = require "nvim-autopairs.rule"
local npairs = require "nvim-autopairs"

npairs.add_rule(Rule("$", "$", "tex"):with_move(function(opts)
  if opts.char == "$" then
    return true
  end
  return false
end))
