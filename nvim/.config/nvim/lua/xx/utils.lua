M = {}

function M.fetch_selection(mode)
  local srow, scol, erow, ecol, _
  if mode == 'n' then
    _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
    _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))
  else
    _, srow, scol, _ = unpack(vim.fn.getpos('v'))
    _, erow, ecol, _ = unpack(vim.fn.getpos('.'))
  end
  if srow > erow then
    srow, erow = erow, srow
    scol, ecol = ecol, scol
  end
  if srow == erow and scol > ecol then
    scol, ecol = ecol, scol
  end
  local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  local n_lines = erow - srow + 1
  lines[1] = string.sub(lines[1], scol)
  if n_lines == 1 then
    lines[1] = string.sub(lines[1], 1, ecol - scol + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, ecol)
  end
  return lines
end

function M.set_indent(num)
  vim.opt_local.tabstop = num
  vim.opt_local.shiftwidth = num
  vim.opt_local.softtabstop = num
end

function M.find_bottom_up_project_root_dir(root_patterns)
  local root_dir = ""
  for _, pattern in ipairs(root_patterns) do
    local find_result = vim.fn.finddir(pattern, '.;' .. (#root_dir > 0 and root_dir or os.getenv('HOME')))
    if #find_result > 0 then
      root_dir = vim.fn.fnamemodify(find_result, ':h')
    end
  end
  return #root_dir > 0 and root_dir or nil
end

return M
