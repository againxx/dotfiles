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


return M
