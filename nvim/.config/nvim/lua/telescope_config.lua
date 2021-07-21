require('telescope').setup {
    defaults = {
        prompt_prefix = ' ',
        selection_caret = '❯ ',
        dynamic_preview_title = true,
        mappings = {
            i = {
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
                ['<Esc>'] = 'close',
                ['<C-o>'] = { '<Cmd>stopinsert<CR>', type = 'command' }
            }
        },
        layout_config = {
            horizontal = {
                preview_width = 0.65
            }
        },
    }
}

require('telescope').load_extension('coc')
require('telescope').load_extension('fzy_native')

local themes = require('telescope.themes')
local actions = require('telescope.actions')

local M = {}
function M.edit_vimrc()
    require('telescope.builtin').find_files {
        cwd = '~/.config/nvim',
        hidden = true,
        path_display = {
            shorten = 2,
        },
        prompt_title = 'Vim Configs',
        layout_strategy = 'horizontal',
        layout_config = {
            height = 20,
            preview_width = 0.75,
        },
    }
end

function M.edit_vim_plugins()
    require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath('data')..'/site/pack/packer/',
        hidden = true,
        path_display = {
            shorten = 2,
        },
        prompt_title = 'Vim Plugins',
        layout_strategy = 'horizontal',
        layout_config = {
            height = 20,
            preview_width = 0.75,
        },
    }
end

function M.edit_dotfiles()
    require('telescope.builtin').git_files {
        cwd = '~/dotfiles',
        prompt_title = 'Dotfiles',
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.65,
        },
    }
end

function M.edit_dictionaries()
    local opts = themes.get_dropdown {
        cwd = '~/dotfiles/vim/cSpell_dictionaries',
        prompt_title = 'Dictionaries',
        layout_config = {
            height = 10,
        },
    }
    require('telescope.builtin').find_files(opts)
end

function M.edit_tmuxp()
    require('telescope.builtin').find_files {
        cwd = '~/.config/tmuxp',
        prompt_title = 'Tmuxp Profiles',
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.65,
            height = 20,
        },
    }
end

function M.oldfiles()
    require('telescope.builtin').oldfiles {
        path_display = {
            shorten = 2,
        },
    }
end

function M.file_browser()
    require('telescope.builtin').file_browser {
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        },
        attach_mappings = function (_, map)
            map('i', '<C-l>', actions.select_default + actions.center)
            map('n', 'l', actions.select_default + actions.center)
            return true
        end
    }
end

function M.man_pages()
    require('telescope.builtin').man_pages {
        layout_strategy = 'vertical'
    }
end

function M.jumplist()
    require('telescope.builtin').jumplist {
        layout_strategy = 'vertical',
        path_display = {
            shorten = 2,
        },
    }
end

function M.current_buffer_fuzzy_find(current_word)
    local opts = themes.get_ivy {
        attach_mappings = function (_, map)
            map('i', '<C-l>', function ()
                vim.fn.feedkeys(current_word, 'n')
            end)
            return true
        end
    }
    require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.git_bcommits()
    require('telescope.builtin').git_bcommits {
        current_file = vim.fn.expand('%:p')
    }
end

function M.asynctasks()
    require('telescope').extensions.asynctasks.all {
        layout_config = {
            height = 20,
        },
        layout_strategy = 'vertical',
    }
end

function M.tags()
    require('telescope.builtin').tags {
        ctags_file = '.vimwiki_tags',
    }
end

function M.document_symbols()
    require('telescope').extensions.coc.document_symbols {
        layout_strategy = 'vertical',
        layout_config = {
            preview_height = 0.70,
        },
    }
end

function M.grep_selected()
  local _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
  local _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))
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
  require('telescope.builtin').grep_string({search = table.concat(lines, '')})
end

return M
