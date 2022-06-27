require "cmp.zi"

require("cmp").setup.buffer {
  sources = {
    { name = "luasnip" },
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
