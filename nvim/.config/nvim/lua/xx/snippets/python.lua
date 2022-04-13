local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require "luasnip.extras.expand_conditions"
local VISUAL = require("xx.snippets.utils").VISUAL

local show_line_begin = require("xx.snippets.utils").show_line_begin

local import_as = function(trigger, import_str, as_str)
  return s(trigger, t(string.format("import %s as %s", import_str, as_str)), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor)
      return show_line_begin(line_to_cursor, trigger)
    end,
  })
end

local get_quoting_style = function()
  if vim.g.luasnips_python_quoting_style == "double" then
    return '"'
  else
    return "'"
  end
end

local snippets = {
  import_as("impnp", "numpy", "np"),
  import_as("imppd", "pandas", "pd"),
  import_as("impplt", "matplotlib.pyplot", "plt"),
  import_as("impo3d", "open3d", "o3d"),
  import_as("imptf", "tensorflow", "tf"),
  s("imptest", {
    t "import pytest",
    {
      condition = conds.line_begin,
      show_condition = function(line_to_cursor)
        return show_line_begin(line_to_cursor, "imptest")
      end,
    },
  }),
  s("impto", {
    t "import torch",
    c(1, {
      t "",
      t { "", "from torch import nn" },
    }),
  }, {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor)
      return show_line_begin(line_to_cursor, "impto")
    end,
  }),
  s(
    "ifmain",
    fmt(
      [[
    if __name__ == {}__main__{}:
    	{}
  ]],
      {
        f(get_quoting_style),
        f(get_quoting_style),
        VISUAL("main()"),
      }
    )
  ),
  s("tyignore", t("# type: ignore")),
}

return snippets
