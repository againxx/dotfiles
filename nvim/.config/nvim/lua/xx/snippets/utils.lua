local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node

M = {}

function M.show_line_begin(line_to_cursor, trigger)
  local removed_space = line_to_cursor:match("^%s*(%w*)")
  return #removed_space > 0 and trigger:match("^" .. removed_space)
end

function M.get_left_curly_brace_style()
  local style = vim.b.luasnip_cpp_style
  if style == nil then
    style = vim.g.luasnip_cpp_style or "google"
  end
  if style == "google" then
    return { " {" }
  else
    return { "", "{" }
  end
end

function M.get_right_curly_brace_style(_, _, str_after_brace)
  local style = vim.b.luasnip_cpp_style
  if style == nil then
    style = vim.g.luasnip_cpp_style or "google"
  end
  if style == "google" then
    return "} " .. str_after_brace .. " {"
  else
    return { "}", str_after_brace, "{" }
  end
end

function M.math_s(...)
  local in_mathzone = function() return vim.fn["vimtex#syntax#in_mathzone"]() == 1 end
  local params = {...}
  table.insert(params, {
    condition = in_mathzone,
    show_condition = in_mathzone,
  })
  return s(unpack(params))
end

function M.VISUAL()
  return f(function(_, snip) return snip.env.SELECT_DEDENT end, {})
end

return M
