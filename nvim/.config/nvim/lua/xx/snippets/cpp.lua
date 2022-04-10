local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local get_left_curly_brace_style = require("xx.snippets.utils").get_left_curly_brace_style
local get_right_curly_brace_style = require("xx.snippets.utils").get_right_curly_brace_style
local VISUAL = require("xx.snippets.utils").VISUAL

ls.filetype_extend("cpp", { "c" })

local show_line_begin = require("xx.snippets.utils").show_line_begin

local include_std_header = function(trigger, header_file)
  return s(trigger, t("#include <" .. header_file .. ">"), {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor)
      return show_line_begin(line_to_cursor, trigger)
    end,
  })
end

local add_single_parameter_template = function(trigger, template, default_value)
  default_value = default_value or "int"
  return s(
    trigger,
    fmt(string.format("%s<{}>", template), {
      i(1, default_value),
    })
  )
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
    t "#include ",
    c(1, {
      sn(nil, {
        t "<",
        r(1, "header_file", {
          f(function(_, parent)
            return parent.snippet.captures[1]
          end),
          i(1),
        }),
        t ">",
      }),
      sn(nil, { t '"', r(1, "header_file"), t '"' }),
    }),
  }),
  s("cout", {
    t "std::cout << ",
    VISUAL(),
    i(1),
    t " << ",
    i(2, [['\n';]]),
  }),
  s("cerr", {
    t "std::cerr << ",
    i(0),
    t [[ << '\n';]],
  }),
  s(
    "tmain",
    fmta(
      [=[
    int main(int argc, char* argv[])<>
    	::testing::InitGoogleTest(&argc, argv);
    	return RUN_ALL_TESTS();
    }
    ]=],
      {
        f(get_left_curly_brace_style, {}),
      }
    )
  ),
  s("tp", fmt([[template<typename {}>]], { i(1, "T") })),
  s(
    "try",
    fmta(
      [[
  try<>
  	<><>
  <> (<>)<>
    <>
  }
  ]],
      {
        f(get_left_curly_brace_style, {}),
        f(function(_, snip)
          return snip.env.SELECT_DEDENT
        end, {}),
        i(1),
        f(get_right_curly_brace_style, {}, { user_args = { "catch" } }),
        i(2, "std::runtime_error err"),
        f(get_left_curly_brace_style, {}),
        i(0),
      }
    )
  ),
  add_single_parameter_template("map<", "std::map"),
  add_single_parameter_template("vec<", "std::vector"),
  add_single_parameter_template("set<", "std::set"),
  add_single_parameter_template("uptr<", "std::unique_ptr"),
  add_single_parameter_template("sptr<", "std::shared_ptr"),
  add_single_parameter_template("wptr<", "std::weak_ptr"),
  add_single_parameter_template("ulk<", "std::unique_lock", "std::mutex"),
  add_single_parameter_template("lkg<", "std::lock_guard", "std::mutex"),
}

return snippets
