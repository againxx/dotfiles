require "note.markdown"
require("note.markdown_vimwiki").init()
require "cmp.zi"
require("jieba-ci").init()
require("xx.utils").set_indent(2)

require("cmp").setup.buffer {
  sources = {
    { name = "luasnip" },
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

local success, wk = pcall(require, "which-key")
if not success then
  return
end

local bufnr = vim.api.nvim_get_current_buf()

wk.add {
  {
    "<leader>cL",
    "<cmd>lua require('xx.toggles').toggle_left_equation()<cr>",
    desc = "Toggle left equation",
    buffer = bufnr,
  },
  { "<leader>op", "<cmd>MarkdownPreview<cr>", desc = "Open markdown preview", buffer = bufnr },
  { "[h", "<Plug>Markdown_MoveToCurHeader", desc = "Move to current header", buffer = bufnr },
  { "<leader>sa", "<cmd>ObsidianTags<cr>", desc = "Fuzzy find tags", buffer = bufnr },
}

wk.add {
  mode = { "i" },
  { ";1", "#<space>", buffer = bufnr, desc = "Header 1" },
  { ";2", "##<space>", buffer = bufnr, desc = "Header 2" },
  { ";3", "###<space>", buffer = bufnr, desc = "Header 3" },
  { ";4", "####<space>", buffer = bufnr, desc = "Header 4" },
  { ";C", "```<cr>```<esc>ka", buffer = bufnr, desc = "Code" },
  { ";M", "$$<cr>$$<esc>O", buffer = bufnr, desc = "Math block" },
  { ";a", "[](<++>)<space><++><esc>F[a", buffer = bufnr, desc = "Link" },
  { ";b", "****<space><++><esc>F*hi", buffer = bufnr, desc = "Bold" },
  { ";d", "~~~~<space><++><esc>F~hi", buffer = bufnr, desc = "Delete" },
  { ";i", "__<space><++><esc>F_i", buffer = bufnr, desc = "Italic" },
  { ";p", "![](<++>)<space><++><esc>F[a", buffer = bufnr, desc = "Picture" },
  { ";r", "##<space>Reference<cr><esc>", buffer = bufnr, desc = "Reference" },
}
