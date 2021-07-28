local colors = {
  black        = '#1F2430',
  white        = '#CBCCC6',
  red          = '#F28779',
  green        = '#BAE67E',
  blue         = '#73D0FF',
  orange       = '#F29E74',
  yellow       = '#FFD580',
  magenta      = '#D4BFFF',
  darkmagenta  = '#A37ACC',
  cyan         = '#95E6CB',
  gray         = '#33415E',
  darkgray     = '#232834',
  lightgray    = '#5C6773',
  inactivegray = '#707A8C',
  transparent  = 'NONE',
}
local ayu_mirage = {
  normal = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.transparent, fg = colors.lightgray },
    z = { bg = colors.green, fg = colors.black },
  },
  insert = {
    a = { bg = colors.transparent, fg = colors.orange, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.blue, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  visual = {
    a = { bg = colors.transparent, fg = colors.orange, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.yellow, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.black, fg = colors.white },
    z = { bg = colors.red, fg = colors.black },
  },
  command = {
    a = { bg = colors.transparent, fg = colors.orange, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.magenta, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  inactive = {
    a = { bg = colors.transparent, fg = colors.lightgray },
    b = { bg = colors.transparent, fg = colors.lightgray },
    c = { bg = colors.darkgray, fg = colors.lightgray },
    z = { bg = colors.transparent, fg = colors.lightgray },
  }
}

local symbols = {
  read_only = '',
  lsp_status = ' ',
  treesitter_status = ' ',
  explorer = ' ',
  undotree = ' ',
  mode = ' ',
  ruler = '',
  err = os.getenv('KITTY_WINDOW_ID') and '理' or 'ﲅ ',
  warn = os.getenv('KITTY_WINDOW_ID') and ' ' or 'ﲍ ',
  info = os.getenv('KITTY_WINDOW_ID') and ' ' or 'ﳃ ',
  ros_package = os.getenv('KITTY_WINDOW_ID') and ' ' or 'ﮧ ',
  catkin_package = os.getenv('KITTY_WINDOW_ID') and ' ' or 'ﲎ ',
}

local hide_when_narrow = function(width)
  return function()
    return vim.fn.winwidth(0) > width
  end
end

local git_branch = function()
  local branch = vim.g.coc_git_status or ''
  return string.gsub(branch, '%s$', '')
end

local git_diff = function()
  local diff = vim.b.coc_git_status or ''
  return string.gsub(diff, '^%s', '')
end

local read_only = function()
  local blacklist = { 'help', 'coc-explorer' }
  if vim.bo.readonly and not vim.tbl_contains(blacklist, vim.bo.filetype) then
    return symbols.read_only
  else
    return ''
  end
end

local coc_status = function()
  local status = vim.g.coc_status
  if status and #status > 0 then
    return symbols.lsp_status .. status
  else
    return ''
  end
end

local treesitter_status = function()
  local status = vim.fn['nvim_treesitter#statusline'] {
    indicator_size = 100,
    type_patterns = { 'class', 'function', 'method' },
  }
  if status and status ~= vim.NIL and #status > 0 then
    if vim.bo.filetype == 'cpp' then
      status = status:gsub('%w+::', '')
    end
    return symbols.treesitter_status .. status:sub(-100 * vim.fn.winwidth(0) / vim.go.columns)
  end
end

local ros_package = function()
  local package_name_with_symbol = ''
  if vim.b.ros_package_name then
    package_name_with_symbol =  symbols.ros_package .. vim.b.ros_package_name
  elseif vim.b.catkin_package_name then
    package_name_with_symbol = symbols.catkin_package .. vim.b.catkin_package_name
  end
  return package_name_with_symbol
end

local coc_explorer = {
  sections = {
    lualine_b = {
      function() return symbols.explorer .. 'Explorer' end,
    }
  },
  filetypes = { 'coc-explorer' }
}

local undotree = {
  sections = {
    lualine_b = {
      function() return symbols.undotree .. 'Undotree' end,
    }
  },
  filetypes = { 'undotree' }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = ayu_mirage,
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icon = symbols.mode,
        format = function(mode) return string.sub(mode, 1, 1) end
      }
    },
    lualine_b = {
      {
        git_branch,
        right_padding = 0,
      },
      {
        git_diff,
        padding = 0,
        condition = hide_when_narrow(140)
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = false,
        path = 1,
      },
      read_only,
      coc_status,
      {
        treesitter_status,
        condition = hide_when_narrow(120),
      }
    },
    lualine_x = {
      {
        ros_package,
        condition = hide_when_narrow(140)
      },
      'filetype',
    },
    lualine_y = {
      {
        'diagnostics',
        sources = { 'coc' },
        sections = { 'error', 'warn', 'info' },
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.cyan,
        symbols = { error = symbols.err, warn = symbols.warn, info = symbols.info }
      },
      'progress',
    },
    lualine_z = {
      {
        'location',
        icon = symbols.ruler,
        format = function(location) return string.gsub(location, ':', '') end
      }
    }
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
        file_status = false,
      },
      read_only,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'location',
        icon = symbols.ruler,
        format = function(location) return string.gsub(location, ':', '') end
      }
    }
  },
  tabline = {},
  extensions = { 'quickfix', coc_explorer, undotree }
}
