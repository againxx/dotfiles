local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("vimwiki", { "tex" })

local snippets = {
  s(
    "paperread",
    fmt([[
      = {} =
      :paper_reading:

      == First Pass: Title / Abstract / Figures ==

      == Second Pass: Introduction / Conclusion / Figures again / Skim the rest ==

      == Third Pass: Read the paper but skip / skim the math ==

      == Fourth Pass: Read the whole thing but skip the parts that don't make sense ==

      == Questions ==
      === What did the authors try to accomplish? ===

      === What were the key elements of the approach? ===

      === What can you use for yourself? ===

      === What other references do you want to follow? ===
      ]], {
        f(function()
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          for _, line in ipairs(lines) do
            local title = line:match "^%%title (.*)$"
            if title ~= nil then
              return title
            end
          end
          return ""
        end, {})
      }
    )
  ),
}

return snippets
