local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node
local conds = require("luasnip.extras.expand_conditions")

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
  local in_mathzone = function()
    if vim.bo.filetype == "tex" then
      return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    elseif vim.bo.filetype == "vimwiki" then
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      local groups = vim.fn.synstack(cursor_pos[1], cursor_pos[2])
      for _, gid in ipairs(groups) do
        if vim.fn.synIDattr(gid, "name") == "textSnipTEX" then
          return true
        end
      end
      return false
    end
    return false
  end
  local params = {...}
  -- normally we only need to customize condition
  if params[#params].condition then
    local original_condition = params[#params].condition
    params[#params].condition = function(...) return in_mathzone() and original_condition(...) end
  else
    table.insert(params, {
      condition = in_mathzone,
      show_condition = in_mathzone,
    })
  end
  return s(unpack(params))
end

function M.VISUAL(default)
  default = default or ""
  return f(function(_, snip)
    if snip.env and #snip.env.SELECT_DEDENT ~= 0 then
      return snip.env.SELECT_DEDENT
    elseif snip.parent and snip.parent.env and #snip.parent.env.SELECT_DEDENT ~= 0 then
      return snip.parent.env.SELECT_DEDENT
    else
      return default
    end
  end)
end

function M.line_begin(trigger)
  return {
    condition = conds.line_begin,
    show_condition = function(line_to_cursor)
      return require("xx.snippets.utils").show_line_begin(line_to_cursor, trigger)
    end,
  }
end

return M
