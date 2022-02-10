local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local get_left_curly_brace_style = require("xx.snippets.utils").get_left_curly_brace_style

ls.filetype_extend("cpp", {"c"})

local show_line_begin = require("xx.snippets.utils").show_line_begin

local snippets = {
  s("incio", t("#include <iostream>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incio") end,
  }),
  s("incvec", t("#include <vector>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incvec") end,
  }),
  s("incarr", t("#include <array>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incarr") end,
  }),
  s("incls", t("#include <list>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incls") end,
  }),
  s("incal", t("#include <algorithm>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incal") end,
  }),
  s("incstr", t("#include <string>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incstr") end,
  }),
  s("incmap", t("#include <map>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incmap") end,
  }),
  s("incset", t("#include <set>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incset") end,
  }),
  s("incumap", t("#include <unordered_map>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incumap") end,
  }),
  s("incexc", t("#include <stdexcept>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incexc") end,
  }),
  s("incmem", t("#include <memory>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incmem") end,
  }),
  s("incros", t("#include <ros/ros.h>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incros") end,
  }),
  s("inctest", t("#include <gtest/gtest.h>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "inctest") end,
  }),
  s("incmock", t("#include <gmock/gmock.h>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incmock") end,
  }),
  s("incben", t("#include <benchmark/benchmark.h>"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, "incben") end,
  }),
  s({ trig = "^%s*inc(%w+)", regTrig = true, hidden = true }, {
    t("#include "),
    c(1, {
      sn(nil, { t("<"), r(1, "header_file", { f(function(_, parent) return parent.snippet.captures[1] end), i(1) }), t(">") }),
      sn(nil, { t('"'), r(1, "header_file"), t('"') }),
    })
  }
  ),
  s("cout", {
    t("std::cout << "),
    f(function(_, snip) return snip.env.SELECT_DEDENT end, {}),
    i(1),
    t(" << "),
    i(2, [['\n';]]),
  }),
  s("cerr", {
    t("std::cerr << "),
    i(0),
    t([[ << '\n';]]),
  }),
  s("tmain",
    fmta([=[
    int main(int argc, char* argv[])<>
    	::testing::InitGoogleTest(&argc, argv);
    	return RUN_ALL_TESTS();
    }
    ]=], {
      f(get_left_curly_brace_style, {}),
    })
  ),
}

return snippets
