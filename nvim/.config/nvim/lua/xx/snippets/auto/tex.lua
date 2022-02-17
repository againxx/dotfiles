local ls = require "luasnip"
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local math_s = require("xx.snippets.utils").math_s
local VISUAL = require("xx.snippets.utils").VISUAL

local auto_backslash = function(triggers)
  local without_pre_backslash = function(line_to_cursor, matched_trigger)
    return #line_to_cursor == #matched_trigger
      or line_to_cursor:sub(-#matched_trigger - 1, -#matched_trigger) ~= "\\"
  end
  local result_snippets = {}
  for _, trig in ipairs(triggers) do
    table.insert(
      result_snippets,
      math_s(trig, { t "\\", t(trig) }, {
        condition = without_pre_backslash,
      })
    )
  end
  return unpack(result_snippets)
end

local snippets = {
  math_s("...", t "\\cdots "),
  math_s("=>", t "\\implies "),
  math_s("=<", t "\\impliedby "),
  math_s("->", t "\\rightarrow "),
  math_s("-<", t "\\leftarrow "),
  math_s(">=", t "\\geq "),
  math_s("<=", t "\\leq "),
  math_s("!=", t "\\neq "),
  math_s("**", t "\\times "),
  math_s("ooo", t "\\infty"),
  math_s("ooo", t "\\infty"),
  math_s(
    "sq",
    fmta(
      [[
  \sqrt{<><>}
  ]],
      {
        VISUAL(),
        i(1),
      }
    )
  ),
  math_s(
    { trig = "(%a)(%d)", regTrig = true },
    f(function(_, parent)
      return parent.snippet.captures[1] .. "_" .. parent.snippet.captures[2]
    end)
  ),
  math_s(
    { trig = "(%a)_(%d%d)", regTrig = true },
    f(function(_, parent)
      return parent.snippet.captures[1] .. "_{" .. parent.snippet.captures[2] .. "}"
    end)
  ),
  math_s(
    "//",
    fmta(
      [[
  \frac{<>}{<>}
  ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  math_s({ trig = "([%d%a^_{}\\]+)/", regTrig = true }, { -- symbol frac
    f(function(_, parent)
      return "\\frac{" .. parent.snippet.captures[1] .. "}{"
    end),
    i(1),
    t "}",
  }, {
    condition = function(_, _, captures)
      -- we need to construct a more complicated regex using vim.regex
      local strict_regex = vim.regex [[\v^(\d+)|(\d*)(\\)?(\a+)((\^|_)(\{\d+\}|\d))*$]]
      return strict_regex:match_str(captures[1]) ~= nil
    end,
  }),
  math_s({ trig = "^(.*%))(%^.*[%d}])/", regTrig = true }, { -- ()^2 frac
    f(function(_, parent)
      local depth = 0
      local capture = parent.snippet.captures[1]
      local j = #capture
      while true do
        if capture:sub(j, j) == ")" then
          depth = depth + 1
        end
        if capture:sub(j, j) == "(" then
          depth = depth - 1
        end
        if depth == 0 then
          break
        end
        j = j - 1
      end
      return capture:sub(1, j - 1) .. "\\frac{" .. capture:sub(j, -1) .. parent.snippet.captures[2] .. "}{"
    end),
    i(1),
    t "}",
  }, {
    condition = function(_, _, captures)
      P(captures)
      local strict_regex = vim.regex [=[\^\d\|\^{[^{}]\+}]=]
      return strict_regex:match_str(captures[2]) ~= nil
    end,
  }),
  math_s({ trig = "^(.*%))/", regTrig = true }, { -- () frac
    f(function(_, parent)
      local depth = 0
      local capture = parent.snippet.captures[1]
      local j = #capture
      while true do
        if capture:sub(j, j) == ")" then
          depth = depth + 1
        end
        if capture:sub(j, j) == "(" then
          depth = depth - 1
        end
        if depth == 0 then
          break
        end
        j = j - 1
      end
      return capture:sub(1, j - 1) .. "\\frac{" .. capture:sub(j, -1) .. "}{"
    end),
    i(1),
    t "}",
  }),
  auto_backslash {
    "sin",
    "cos",
    "arccot",
    "cot",
    "csc",
    "ln",
    "log",
    "exp",
    "star",
    "perp",
    "geq",
    "leq",
    "quad",
    "equiv",
    "sup",
    "inf",
    "max",
    "min",
    "arg",
  },
}

return snippets
