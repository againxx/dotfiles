local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local math_s = require("xx.snippets.utils").math_s
local VISUAL = require("xx.snippets.utils").VISUAL

local snippets = {
  math_s("lrB", fmta([[
  \left\{ <><> \right\}
  ]], {
    VISUAL(),
    i(1),
  })),
  math_s("lrr", fmta([[
  \lbrack <><> \rbrack
  ]], {
    VISUAL(),
    i(1),
  })),
  math_s({trig = "mbb", wordTrig = false}, {
    t("\\mathbb{"),
    i(1),
    t("}")
  }),
  math_s({trig = "mcal", wordTrig = false}, {
    t("\\mathcal{"),
    i(1),
    t("}")
  })
}

return snippets
