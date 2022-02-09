M = {}

function M.show_line_begin(line_to_cursor, trigger)
  local removed_space = line_to_cursor:match("^%s*(%w*)")
  return #removed_space > 0 and trigger:match("^" .. removed_space)
end

return M
