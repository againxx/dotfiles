local success, telescope = pcall(require, 'telescope')
if not success then
  error('This plugins requires nvim-telescope/telescope.nvim')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local entry_display = require('telescope.pickers.entry_display')
local Path = require('plenary.path')

local conf = require('telescope.config').values

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

local zettel_open = function(opts)
  opts = opts or {}
  local wikinumber = vim.fn['vimwiki#vars#get_bufferlocal']('wiki_nr')
  local results = vim.fn['vimwiki#base#get_wikilinks'](wikinumber, 1, '')
  results = vim.tbl_filter(function(v) return v:sub(1, 1) == '/' end, results)
  pickers.new (opts, {
    prompt_title = 'Open zettel notes',
    finder = finders.new_table {
      results = results,
      entry_maker = gen_from_wiki_name(opts),
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = conf.file_previewer(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = actions.get_selected_entry()
        do_close(prompt_bufnr, true)
        require'telescope.builtin'.find_files{cwd=selection.filename}
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
