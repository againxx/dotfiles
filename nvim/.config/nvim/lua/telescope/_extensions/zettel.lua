local success, telescope = pcall(require, 'telescope')
if not success then
  error('This plugins requires nvim-telescope/telescope.nvim')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')
local Path = require('plenary.path')

local conf = require('telescope.config').values

local staged_finder = function(opts)
  local wikinumber = vim.fn['vimwiki#vars#get_bufferlocal']('wiki_nr')
  local results = vim.fn['vimwiki#base#get_wikilinks'](wikinumber, 1, '')
  results = vim.tbl_filter(function(v) return v:sub(1, 1) == '/' end, results)

  local gen_from_wiki_name = function(opts)
    local displayer = entry_display.create {
      separator = " ",
      items = {
        { remaining = true },
      },
    }

    local make_display = function(entry)
      local title = vim.fn['zettel#vimwiki#get_title'](entry.filename)
      if title == '' then
        local wikiname = vim.fn.fnamemodify(entry.filename, ":t:r")
        -- use the Zettel filename as title if it is empty
        title = wikiname
      end
      return displayer {
        title,
      }
    end

    return function(wiki_name)
      local wiki_root = vim.fn['vimwiki#vars#get_wikilocal']('path')
      local wiki_ext = vim.fn['vimwiki#vars#get_wikilocal']('ext')
      return {
        ordinal = wiki_name,
        -- Path to package.xml for file preview
        -- path = Path:new(wiki_root .. wiki_name:sub(2) .. wiki_ext):absolute(),
        value = wiki_name:sub(2),
        -- Path to the package root
        filename = Path:new(wiki_root .. wiki_name:sub(2) .. wiki_ext):absolute(),
        -- pkg_type = type,
        display = make_display
      }
    end
  end
  return finders.new_table { results = results, entry_maker = gen_from_wiki_name(opts) }
end

local zettel_open = function(opts)
  opts = opts or {}
  pickers.new (opts, {
    prompt_title = 'Open zettel notes',
    finder = staged_finder(opts),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = conf.file_previewer(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local _, col = vim.api.nvim_win_get_cursor(0)
        local text_before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        if text_before_cursor:match('.*%[%[$') then
          vim.schedule(function()
            vim.api.nvim_put({ selection.value }, 'c', true, false)
          end)
        else
          vim.schedule(function()
            vim.api.nvim_put({ '[[' .. selection.value }, 'c', true, false)
          end)
        end
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension {
  exports = {
    zettel_open = zettel_open,
  }
}
