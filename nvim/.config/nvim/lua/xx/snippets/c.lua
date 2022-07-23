---@diagnostic disable:undefined-global
local show_line_begin = require("xx.snippets.utils").show_line_begin
local get_left_curly_brace_style = require("xx.snippets.utils").get_left_curly_brace_style
local get_right_curly_brace_style = require("xx.snippets.utils").get_right_curly_brace_style
local VISUAL = require("xx.snippets.utils").VISUAL

local include_std_header = function(trigger, header_file)
  return s(trigger, t("#include <" .. header_file .. ">"), {
    condition = function(line_to_cursor, matched_trigger)
      return conds.line_begin(line_to_cursor, matched_trigger) and vim.bo.filetype == "c"
    end,
    show_condition = function(line_to_cursor)
      return show_line_begin(line_to_cursor, "incio") and vim.bo.filetype == "c"
    end,
  })
end

local branch_block_with_choice = function(branch_type)
  return c(1, {
    fmta(
      [[
      <> (<>)<>
      	<><>
      }
      ]],
      {
        t(branch_type),
        r(1, "condition", i(nil, "/* condition */")),
        f(get_left_curly_brace_style),
        VISUAL(),
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
        r(1, "condition"),
        VISUAL(),
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
      fmta(
        [[
      else<>
      	<><>
      }
      ]],
        {
          f(get_left_curly_brace_style),
          VISUAL(),
          i(1),
        }
      ),
      fmt(
        [[
      else
      	{}{}
      ]],
        {
          VISUAL(),
          i(1),
        }
      ),
    })
  ),
  s(
    "ife",
    fmta(
      [[
      if (<>)<>
      	<><>
      <>
      	<><>
      }
      ]],
      {
        i(1, "/* condition */"),
        f(get_left_curly_brace_style),
        VISUAL(),
        i(2),
        f(get_right_curly_brace_style, {}, { user_args = { "else" } }),
        VISUAL(),
        i(0),
      }
    )
  ),
  s(
    "for",
    c(1, {
      fmta(
        [[
    for (<>)<>
    	<><>
    }
    ]],
        {
          r(1, "loop_body"),
          f(get_left_curly_brace_style),
          VISUAL(),
          i(2),
        }
      ),
      fmt(
        [[
      for ({})
      	{}{}
      ]],
        {
          r(1, "loop_body"),
          VISUAL(),
          i(0),
        }
      ),
    }),
    {
      stored = {
        loop_body = fmt(
          [[{} {} = {}; {} < {}; ++{}]],
          { i(4, "int"), i(1, "i"), i(3, "0"), rep(1), i(2, "count"), rep(1) }
        ),
      },
    }
  ),
  include_std_header("incio", "stdio.h"),
  include_std_header("inclib", "stdlib.h"),
  include_std_header("incuni", "unistd.h"),
  include_std_header("incstr", "string.h"),
  include_std_header("inceno", "errno.h"),
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
  s(
    "main",
    fmta(
      [[
    int main(<>)<>
    	<><>
    	return 0;
    }
    ]],
      {
        c(2, { t "", t "int argc, char* argv[]" }),
        f(get_left_curly_brace_style),
        VISUAL(),
        i(1),
      }
    )
  ),
  s(
    "guard",
    fmt(
      [[
    #ifndef {}
    #define {}

    {}{}

    #endif  // {}
    ]],
      {
        dl(1, l.TM_FILENAME_BASE:gsub("[^A-Za-z0-9]+", "_"):upper(), {}),
        rep(1),
        VISUAL(),
        i(0),
        rep(1),
      }
    )
  ),
}

return snippets
