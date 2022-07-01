require "cmp.zi"

require("cmp").setup.buffer {
  sources = {
    { name = "neorg" },
    { name = "katex" },
    { name = "luasnip" },
    { name = "tmux" },
    {
      name = "zi",
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true,
        --dict = '/usr/share/dict/words'
      },
    },
    { name = "buffer" },
  },
}

local Job = require('plenary.job')
local neorg_pandoc = "neorg-pandoc-linux86"

local update_pdf = function(output_file)
  output_file = output_file or vim.fn.expand("%:p:r") .. ".pdf"
  if vim.fn.executable(neorg_pandoc) > 0 and vim.fn.executable("pandoc") > 0 then
    local j1 = Job:new({
      command = neorg_pandoc,
      args = { vim.fn.expand("%:p") },
    })
    local j2 = Job:new({
      command = "sed",
      args = { [=[s/\[1,22,1\]/[1,20]/]=] },
      writer = j1,
    })
    Job:new({
      command = "pandoc",
      args = { "-f", "json", "-o", output_file },
      writer = j2,
    }):start()
  end
end

-- vim.api.nvim_create_augroup("neorg_special", {})
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = "neorg_special",
--   buffer = vim.api.nvim_get_current_buf(),
--   callback = function() update_pdf() end,
-- })
