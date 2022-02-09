local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require "luasnip.extras.expand_conditions"
local show_line_begin = require("xx.snippets.utils").show_line_begin

local get_left_curly_brace_style = function()
  local style = vim.b.luasnips_cpp_style
  if style == nil then
    style = vim.g.luasnips_cpp_style or "google"
  end
  if style == "google" then
    return { " {" }
  else
    return { "", "{" }
  end
end

local get_right_curly_brace_style = function(_, _, str_after_brace)
  local style = vim.b.luasnips_cpp_style
  if style == nil then
    style = vim.g.luasnips_cpp_style or "google"
  end
  if style == "google" then
    return "} " .. str_after_brace .. " {"
  else
    return { "}", str_after_brace, "{" }
  end
end

local branch_block_with_choice = function(branch_type)
  return c(1, {
    fmt(
      [[
      {} ({}){}
      	{}{}
      }}
      ]],
      {
        t(branch_type),
        i(1, "/* condition */"),
        f(get_left_curly_brace_style, {}),
        f(function(_, snip)
          return snip.parent.env.SELECT_DEDENT
        end, {}),
        i(2),
      }
    ),
    fmt(
      [[
      {} ({})
      	{}{}
      ]],
      {
        t(branch_type),
        i(1, "/* condition */"),
        f(function(_, snip)
          return snip.parent.env.SELECT_DEDENT
        end, {}),
        i(2),
      }
    ),
  })
end

local snippets = {
  s("if", branch_block_with_choice "if"),
  s("while", branch_block_with_choice "while"),
  s("eif", branch_block_with_choice "else if"),
  s(
    "else",
    c(1, {
      fmt(
        [[
      else{}
      	{}{}
      }}
      ]],
        {
          f(get_left_curly_brace_style, {}),
          f(function(_, snip)
            return snip.parent.env.SELECT_DEDENT
          end, {}),
          i(1),
        }
      ),
      fmt(
        [[
      else
      	{}{}
      ]],
        {
          f(function(_, snip)
            return snip.parent.env.SELECT_DEDENT
          end, {}),
          i(1),
        }
      ),
    })
  ),
  s(
    "ife",
    fmt(
      [[
      if ({}){}
      	{}{}
      {}
      	{}{}
      }}
      ]],
      {
        i(1, "/* condition */"),
        f(get_left_curly_brace_style, {}),
        f(function(_, snip)
          return snip.env.SELECT_DEDENT
        end, {}),
        i(2),
        f(get_right_curly_brace_style, {}, "else"),
        f(function(_, snip)
          return snip.env.SELECT_DEDENT
        end, {}),
        i(0),
      }
    )
  ),
  s("incio", t "#include <stdio.h>", {
    condition = function(line_to_cursor, matched_trigger)
      return conds.line_begin(line_to_cursor, matched_trigger) and vim.bo.filetype == "c"
    end,
    show_condition = function(line_to_cursor)
      return show_line_begin(line_to_cursor, "incio") and vim.bo.filetype == "c"
    end,
  }),
}

return snippets
