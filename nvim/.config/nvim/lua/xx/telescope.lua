if not pcall(require, 'telescope') then
  return
end

local actions = require('telescope.actions')
local themes = require('telescope.themes')

require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = '❯ ',
    dynamic_preview_title = true,
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-f>'] = 'preview_scrolling_down',
        ['<C-b>'] = 'preview_scrolling_up',
        ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-l>"] = actions.toggle_selection,
        ["<Tab>"] = actions.select_default + actions.center,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ['<Esc>'] = 'close',
        ['<C-o>'] = { '<Cmd>stopinsert<CR>', type = 'command' }
      },
      n = {
        ['<C-f>'] = 'preview_scrolling_down',
        ['<C-b>'] = 'preview_scrolling_up',
        ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
        ["<Tab>"] = actions.select_default + actions.center,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      }
    },
    layout_config = {
      horizontal = {
        preview_width = 0.65
      }
    },
  },
  extensions = {
    fzf_writer = {
      minimum_grep_characters = 3,
      use_highlighter = false,
    },
    frecency = {
      ignore_patterns = {
        "*.git/*",
        "*/tmp/*",
        "*/build/*",
        "*/devel/*",
        "*.cache/*"
      },
      workspaces = {
        ['nvim']    = os.getenv('HOME') .. '/.config/nvim',
        ['scanbot'] = os.getenv('HOME') .. '/Projects/scanbot',
        ['co_scan'] = os.getenv('HOME') .. '/Projects/sem_co_scan_ws',
        ['habitat'] = os.getenv('HOME') .. '/Programming_Learning/habitat_learning',
        ['note']    = os.getenv('HOME') .. '/Documents/Notes',
        ['wiki']    = os.getenv('HOME') .. '/Documents/Vimwiki/wiki',
      }
    }
  }
}

require('telescope').load_extension('coc')
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('frecency')

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
    prompt_title = 'Vim Plugins',
    layout_strategy = 'horizontal',
    layout_config = {
      height = 30,
      preview_width = 0.65,
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
  require('telescope').extensions.frecency.frecency {
    path_display = {
      shorten = 2,
    },
  }
end

function M.buffers()
  require('telescope.builtin').buffers {
    path_display = function(_, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s", tail)
    end,
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

function M.workspace_symbols()
  require('telescope').extensions.coc.workspace_symbols {
    layout_strategy = 'vertical',
    layout_config = {
      preview_height = 0.70,
    },
  }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    path_display = {
      shorten = 1,
    },
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_cursor_word()
  require('telescope.builtin').grep_string {
    path_display = {
      shorten = 1,
    },
    search = vim.fn.expand('<cword>'),
  }
end

function M.grep_selected()
  local lines = require('xx.utils').fetch_selection('n')
  require('telescope.builtin').grep_string({search = table.concat(lines)})
end

function M.grep_last_search(opts)
  opts = opts or {}
  -- -> Subs out the search things
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub('\\C', '')

  opts.path_display = { shorten = 2 }
  opts.word_match = '-w'
  opts.search = register

  require('telescope.builtin').grep_string(opts)
end

function M.ultisnips()
  require('telescope').extensions.ultisnips.ultisnips {
    layout_strategy = 'vertical',
    layout_config = {
      height = 0.6,
      width = 0.5,
    },
  }
end

function M.ros_core_packages()
  local Path = require('plenary.path')
  local scan = require('plenary.scandir')
  local setup_file = scan.scan_dir('/opt', { depth = 3, search_pattern = '.*/setup.zsh$' })
  if #setup_file > 0 then
    local package_path = Path:new(setup_file[1]):parent() .. '/share'
    require('telescope').extensions.ros.packages {
      cwd = package_path
    }
  else
    print('ROS root directory not found!')
  end
end

function M.ros_workspace_packages()
  pcall(require('telescope').extensions.ros.packages, {
    cwd = vim.b.catkin_workspace or '.'
  })
end

return M
