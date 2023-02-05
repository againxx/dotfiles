local ok, db = pcall(require, "dashboard")
if not ok then
  return
end

local plugin_count = #vim.tbl_keys(packer_plugins)

db.setup {
  theme = "doom",
  config = {
    header = {
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      "",
      "",
      "",
    },
    center = {
      {
        icon = "  ",
        desc = "Find file                               ",
        key = "SPC f f",
        action = "lua require('xx.telescope').find_files()",
      },
      {
        icon = "  ",
        desc = "Frequently opened files                 ",
        key = "SPC f o",
        action = "lua require('xx.telescope').oldfiles()",
      },
      {
        icon = "  ",
        desc = "Find word                               ",
        key = "CTRL p ",
        action = "lua require('xx.telescope').live_grep()",
      },
      {
        icon = "  ",
        desc = "Recently saved session                  ",
        key = "SPC s l",
        action = 'lua require("persistence").load({ last = true })',
      },
      {
        icon = "  ",
        desc = "Persional dotfiles                      ",
        key = "SPC e d",
        action = "lua require('xx.telescope').edit_dotfiles()",
      },
      {
        icon = "  ",
        desc = "File browser                            ",
        key = "SPC l f",
        action = "Lf",
      },
      {
        icon = "  ",
        desc = "Book marks                              ",
        key = "SPC o m",
        action = "lua require('xx.telescope').marks()",
      },
      {
        icon = "  ",
        desc = "New file                                       ",
        action = "DashboardNewFile",
      },
    },
    footer = {
      "",
      "",
      "",
      "Happy Hacking 🎉 neovim loaded " .. plugin_count .. " plugins",
    },
  },
}
