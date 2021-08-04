local success, telescope = pcall(require, 'telescope')
if not success then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local entry_display = require('telescope.pickers.entry_display')
local utils = require('telescope.utils')
local conf = require('telescope.config').values

local make_displayer = function(opts)
  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 16 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.ordinal, "TelescopeResultsSpecialComment" },
      entry.filename
      }
  end

  return function(line)
    local pkgname, filename = string.match(line, '.*devel/.private/(.*)/lib/.*/([^/]+)$')
    return {
      ordinal = pkgname,
      value = line,
      filename = filename,
      display = make_display
    }
  end
end

local executables = function(opts)
  if vim.fn.isdirectory(opts.cwd) ~= 1 then
    print('Invalid catkin workspace directory')
    return
  end

  local cmd
  if vim.fn.executable('fd') == 1 then
    cmd = 'fd'
  elseif vim.fn.executable('fdfind') == 1 then
    cmd = 'fdfind'
  else
    print('This plugin requires fd / fdfind to work')
    return
  end
  local results = utils.get_os_command_output({ cmd, '-p', '-H', '-t', 'x', 'devel/.private/.*/lib/', opts.cwd })
  if vim.tbl_isempty(results) then
    return
  end
  pickers.new(opts, {
    prompt_title = 'Catkin executables',
    finder = finders.new_table {
      results = results,
      entry_maker = make_displayer(opts),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local select_executable = function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.b.dap_last_executable = results[selection.index]
        require('xx.dap').continue()
      end

      map('i', '<CR>', select_executable)
      map('n', '<CR>', select_executable)
      return true
    end,
  }):find()
end

return telescope.register_extension {
  exports = {
    executables = executables,
  }
}
