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

-- Parse file. Returns list of all anchors and their position
local get_anchors = function(file_path, syntax)
  local anchors = {}
  if vim.fn.filereadable(file_path) == false then
    return anchors
  end

  local header_regex = vim.fn['vimwiki#vars#get_syntaxlocal']('header_search', syntax)
  local bold_regex = vim.fn['vimwiki#vars#get_syntaxlocal']('bold_search', syntax)
  local tag_regex = vim.fn['vimwiki#vars#get_syntaxlocal']('tag_search', syntax)
  local lnum = 1
  for line in io.lines(file_path) do
    local header_match = vim.fn.matchlist(line, header_regex)
    if #header_match ~= 0 then
      table.insert(anchors, {vim.fn['vimwiki#base#normalize_anchor'](header_match[3]), lnum})
    end

    -- there can be serveral bold text in one line
    local bold_count = 1
    while true do
      local bold_text = vim.fn.matchstr(line, bold_regex, 0, bold_count)
      if bold_text == '' then
        break
      end
      table.insert(anchors, {bold_text, lnum})
      bold_count = bold_count + 1
    end

    -- there can be serveral tags in one line
    local tag_count = 1
    while true do
      local tag_group_text = vim.fn.matchstr(line, tag_regex, 0, tag_count)
      if tag_group_text == '' then
        break
      end
      local sep = vim.fn['vimwiki#vars#get_syntaxlocal']('tag_format', syntax).sep
      for _, tag_text in ipairs(vim.split(tag_group_text, sep)) do
        table.insert(anchors, {tag_text, lnum})
      end
      tag_count = tag_count + 1
    end

    lnum = lnum + 1
  end
  return anchors
end

local staged_finder = function(opts)
  opts.wiki_nr = opts.wiki_nr or vim.fn['vimwiki#vars#get_bufferlocal']('wiki_nr')
  opts.wiki_root = opts.wiki_root or vim.fn['vimwiki#vars#get_wikilocal']('path')
  opts.wiki_ext = opts.wiki_ext or vim.fn['vimwiki#vars#get_wikilocal']('ext')

  local gen_from_wiki_name = function()
    local displayer = entry_display.create {
      separator = " ",
      items = {
        { remaining = true },
      },
    }

    local make_display = function(entry)
      local title = vim.fn['zettel#vimwiki#get_title'](entry.filename)
      if title == '' then
        local wiki_name = vim.fn.fnamemodify(entry.filename, ":t:r")
        -- use the Zettel filename as title if it is empty
        title = wiki_name
      end
      return displayer {
        title,
      }
    end

    return function(wiki_name)
      return {
        ordinal = wiki_name,
        -- path = Path:new(wiki_root .. wiki_name:sub(2) .. wiki_ext):absolute(),
        value = wiki_name:sub(2),
        -- Path to wiki file
        filename = Path:new(opts.wiki_root .. wiki_name:sub(2) .. opts.wiki_ext):absolute(),
        display = make_display
      }
    end
  end

  local gen_from_wiki_anchor = function()
    local displayer = entry_display.create {
      separator = "▏",
      items = {
        { width = 30 },
        { remaining = true },
      },
    }

    local make_display = function(entry)
      return displayer {
        opts.wiki_name,
        entry.value
      }
    end

    return function(anchor)
      return {
        ordinal = anchor[1],
        value = anchor[1],
        -- Path to wiki file
        filename = Path:new(opts.wiki_root .. opts.wiki_name:sub(2) .. opts.wiki_ext):absolute(),
        lnum = anchor[2],
        -- pkg_type = type,
        display = make_display
      }
    end
  end

  if not opts.anchor then
    local results = vim.fn['vimwiki#base#get_wikilinks'](opts.wikinumber, 1, '')
    results = vim.tbl_filter(function(v) return v:sub(1, 1) == '/' end, results)
    return finders.new_table { results = results, entry_maker = gen_from_wiki_name(opts) }
  else
    local link_infos = vim.fn['vimwiki#base#resolve_link'](opts.wiki_name .. '#', opts.wiki_full_path)
    local wiki_file = link_infos.filename
    local syntax = vim.fn['vimwiki#vars#get_wikilocal']('syntax', link_infos.index)
    local anchors = get_anchors(wiki_file, syntax)
    return finders.new_table { results = anchors, entry_maker = gen_from_wiki_anchor(opts) }
  end

end

local zettel_insert_link = function(opts)
  opts = opts or {}
  pickers.new (opts, {
    prompt_title = 'Insert zettel notes',
    finder = staged_finder(opts),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = conf.file_previewer(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local _, col = vim.api.nvim_win_get_cursor(0)
        local text_before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        if text_before_cursor:match('.*%[%[$') then
          vim.api.nvim_put({ selection.value }, 'c', true, true)
        else
          vim.api.nvim_put({ '[[' .. selection.value }, 'c', true, true)
        end
      end)

      local list_anchors = function()
        opts.anchor = true
        opts.wiki_name = action_state.get_selected_entry().value
        opts.wiki_full_path = action_state.get_selected_entry().filename
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker.previewer = conf.qflist_previewer(opts)
        current_picker:refresh(staged_finder(opts), { reset_prompt = true })
      end

      map("i", "<C-l>", list_anchors)
      map("n", "<C-l>", list_anchors)
      return true
    end,
  }):find()
end

return telescope.register_extension {
  exports = {
    zettel_insert_link = zettel_insert_link,
  }
}
