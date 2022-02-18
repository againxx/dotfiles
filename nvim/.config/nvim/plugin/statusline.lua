local colors = {
  black = "#1F2430",
  white = "#CBCCC6",
  red = "#F28779",
  green = "#BAE67E",
  blue = "#73D0FF",
  orange = "#F29E74",
  yellow = "#FFD580",
  magenta = "#D4BFFF",
  darkmagenta = "#A37ACC",
  cyan = "#95E6CB",
  gray = "#33415E",
  darkgray = "#232834",
  lightgray = "#5C6773",
  inactivegray = "#707A8C",
  transparent = "NONE",
}
local ayu_mirage = {
  normal = {
    a = { bg = colors.green, fg = colors.black, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.transparent, fg = colors.lightgray },
    z = { bg = colors.green, fg = colors.black },
  },
  insert = {
    a = { bg = colors.transparent, fg = colors.orange, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.blue, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  visual = {
    a = { bg = colors.transparent, fg = colors.orange, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.yellow, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.black, fg = colors.white },
    z = { bg = colors.red, fg = colors.black },
  },
  command = {
    a = { bg = colors.transparent, fg = colors.orange, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.darkmagenta },
    c = { bg = colors.magenta, fg = colors.black },
    z = { bg = colors.transparent, fg = colors.orange },
  },
  inactive = {
    a = { bg = colors.transparent, fg = colors.lightgray },
    b = { bg = colors.transparent, fg = colors.lightgray },
    c = { bg = colors.darkgray, fg = colors.lightgray },
    z = { bg = colors.transparent, fg = colors.lightgray },
  },
}

local symbols = {
  read_only = "",
  lsp_status = "  ",
  git_branch = " ",
  git_merge = " ",
  normal_diff = " ",
  treesitter_status = " ",
  explorer = " ",
  tree = " ",
  mode = " ",
  ruler = "",
  err = vim.env.KITTY_WINDOW_ID and "理" or "ﲅ ",
  warn = vim.env.KITTY_WINDOW_ID and " " or "ﲍ ",
  info = vim.env.KITTY_WINDOW_ID and " " or "ﳃ ",
  ros_package = vim.env.KITTY_WINDOW_ID and " " or "ﮧ ",
  catkin_package = vim.env.KITTY_WINDOW_ID and " " or "ﲎ ",
}

local lsp_progress = require('lsp-status').status_progress

local hide_when_narrow = function(width)
  return function()
    return vim.fn.winwidth(0) > width
  end
end

local git_branch = function()
  local symbol = symbols.git_branch
  if vim.g.mergetool_in_merge_mode == 1 then
    symbol = symbols.git_merge
  elseif vim.wo.diff then
    symbol = symbols.normal_diff
  end
  local branch = vim.b.gitsigns_head and symbol .. vim.b.gitsigns_head or ""
  return vim.trim(branch)
end

local git_diff = function()
  local diff = vim.b.gitsigns_status or ""
  return vim.trim(diff)
end

local read_only = function()
  local blacklist = { "help", "defx" }
  if vim.bo.readonly and not vim.tbl_contains(blacklist, vim.bo.filetype) then
    return symbols.read_only
  else
    return ""
  end
end

local lsp_status = function()
  local status = lsp_progress()
  if status and #status > 0 then
    return symbols.lsp_status .. status
  else
    return ""
  end
end

local treesitter_status = function()
  local status = vim.fn["nvim_treesitter#statusline"] {
    indicator_size = 100,
    type_patterns = { "class", "function", "method" },
  }
  if status and status ~= vim.NIL and #status > 0 then
    if vim.bo.filetype == "cpp" then
      status = status:gsub("%w+::", "")
    end
    return "%<" .. symbols.treesitter_status .. status
  end
  return ""
end

local ros_package = function()
  local package_name_with_symbol = ""
  if vim.b.ros_package_name then
    package_name_with_symbol = symbols.ros_package .. vim.b.ros_package_name
  elseif vim.b.catkin_package_name then
    package_name_with_symbol = symbols.catkin_package .. vim.b.catkin_package_name
  end
  return package_name_with_symbol
end

local defx_explorer = {
  sections = {
    lualine_b = {
      function()
        return symbols.explorer .. "Explorer"
      end,
    },
  },
  filetypes = { "defx" },
}

local undotree = {
  sections = {
    lualine_b = {
      function()
        return symbols.tree .. "Undotree"
      end,
    },
  },
  filetypes = { "undotree" },
}

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = ayu_mirage,
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icon = symbols.mode,
        fmt = function(mode)
          return string.sub(mode, 1, 1)
        end,
      },
    },
    lualine_b = {
      git_branch,
      {
        git_diff,
        padding = { left = 0 },
        condition = hide_when_narrow(140),
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = false,
        path = 1,
      },
      read_only,
      lsp_status,
      {
        treesitter_status,
        condition = hide_when_narrow(120),
      },
    },
    lualine_x = {
      {
        ros_package,
        condition = hide_when_narrow(140),
      },
      "filetype",
    },
    lualine_y = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info" },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
        symbols = { error = symbols.err, warn = symbols.warn, info = symbols.info },
      },
      "progress",
    },
    lualine_z = {
      {
        "location",
        icon = symbols.ruler,
        fmt = function(location)
          return string.gsub(location, ":", "")
        end,
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        "filename",
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
        "location",
        icon = symbols.ruler,
        fmt = function(location)
          return string.gsub(location, ":", "")
        end,
      },
    },
  },
  tabline = {},
  extensions = { "quickfix", defx_explorer, undotree },
}
