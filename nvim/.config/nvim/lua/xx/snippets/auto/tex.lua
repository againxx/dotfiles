local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local math_s = require("xx.snippets.utils").math_s
local VISUAL = require("xx.snippets.utils").VISUAL

local snippets = {
  math_s("...", t('\\cdots ')),
  math_s("=>", t('\\implies ')),
  math_s("=<", t('\\impliedby ')),
  math_s("->", t('\\rightarrow ')),
  math_s("-<", t('\\leftarrow ')),
  math_s(">=", t('\\geq ')),
  math_s("<=", t('\\leq ')),
  math_s("!=", t('\\neq ')),
  math_s("**", t('\\times ')),
  math_s("ooo", t('\\infty')),
  math_s("ooo", t('\\infty')),
  math_s("sq", fmta([[
  \sqrt{<><>}
  ]], {
    VISUAL(),
    i(1),
  })),
  math_s({trig = "(%a)(%d)", regTrig = true}, f(
    function(_, parent)
      return parent.snippet.captures[1] .. '_' .. parent.snippet.captures[2]
    end
  )),
  math_s({trig = "(%a)_(%d%d)", regTrig = true}, f(
    function(_, parent)
      return parent.snippet.captures[1] .. '_{' .. parent.snippet.captures[2] .. '}'
    end
  )),
  math_s('//', fmta([[
  \frac{<>}{<>}
  ]], {
    i(1),
    i(2)
  })),
  math_s({trig = "([%d%a^_{}\\]+)/", regTrig = true}, {
    f(function(_, parent)
      return '\\frac{' .. parent.snippet.captures[1] .. '}{'
    end),
    i(1),
    t('}'),
  }, {
    condition = function(_, _, captures)
      -- we need to construct a more complicated regex using vim.regex
      local strict_regex = vim.regex [[\v^(\d+)|(\d*)(\\)?(\a+)((\^|_)(\{\d+\}|\d))*$]]
      return strict_regex:match_str(captures[1]) ~= nil
    end
  }
  ),
  math_s({trig = "^(.*%))/", regTrig = true}, {
    f(function(_, parent)
      local depth = 0
      local capture = parent.snippet.captures[1]
      local j = #capture
      while true do
        if capture:sub(j, j) == ')' then
          depth = depth + 1
        end
        if capture:sub(j, j) == '(' then
          depth = depth - 1
        end
        if depth == 0 then
          break
        end
        j = j - 1
      end
      return capture:sub(1, j - 1) .. '\\frac{' .. capture:sub(j, -1) .. '}{'
    end),
    i(1),
    t('}'),
  }),
}

return snippets
