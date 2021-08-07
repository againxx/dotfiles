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
  local root_dirs = {}
  for _, pattern in ipairs(root_patterns) do
    local find_result = vim.fn.finddir(pattern, '.;' .. vim.env.HOME)
    if #find_result > 0 then
      local root_dir = vim.fn.fnamemodify(find_result, ':p:h')
      if vim.fn.isdirectory(find_result) > 0 then
        -- :h modifier will only remove last / for directory, not the directory itself
        -- so we need use another :h
        root_dir = vim.fn.fnamemodify(root_dir, ':h')
      end
      table.insert(root_dirs, root_dir)
    end
  end
  table.sort(root_dirs, function(d1, d2) return #d1 > #d2 end)
  return #root_dirs > 0 and root_dirs[1] or nil
end

function M.delete_finished_terminal_buffers()
  local current_buffers = vim.api.nvim_list_bufs()
  local term_buffers = vim.tbl_filter(function(bufnr) return vim.api.nvim_buf_get_option(bufnr, 'buftype') == 'terminal' end,
    current_buffers)
  for _, term_buffer in ipairs(term_buffers) do
    local is_running = vim.fn.jobwait({vim.api.nvim_buf_get_option(term_buffer, 'channel')}, 0)[0] == -1
    if not is_running then
      vim.api.nvim_buf_delete(term_buffer, {force = true})
    end
  end
end

return M
