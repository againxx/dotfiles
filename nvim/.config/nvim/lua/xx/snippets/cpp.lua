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

local include_std_header = function(trigger, header_file)
  return s(trigger, t("#include <" .. header_file .. ">"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor) return show_line_begin(line_to_cursor, trigger) end,
  })
end

local snippets = {
  include_std_header("incio", "iostream"),
  include_std_header("incvec", "vector"),
  include_std_header("incarr", "array"),
  include_std_header("incls", "list"),
  include_std_header("incal", "algorithm"),
  include_std_header("incstr", "string"),
  include_std_header("incmap", "map"),
  include_std_header("incset", "set"),
  include_std_header("incumap", "unordered_map"),
  include_std_header("incexc", "stdexcept"),
  include_std_header("incmem", "memory"),
  include_std_header("incros", "ros/ros.h"),
  include_std_header("inctest", "gtest/gtest.h"),
  include_std_header("incmock", "gmock/gmock.h"),
  include_std_header("incben", "benchmark/benchmark.h"),
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
