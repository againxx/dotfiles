require("cmp").setup.buffer {
  sources = {
    { name = "neorg" },
    { name = "katex" },
    { name = "luasnip" },
    { name = "tmux" },
    {
      name = "look",
      keyword_length = 3,
      option = {
        convert_case = true,
        loud = true,
        --dict = '/usr/share/dict/words'
      },
    },
    { name = "buffer" },
  },
}

