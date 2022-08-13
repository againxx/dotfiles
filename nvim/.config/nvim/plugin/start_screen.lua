local ok, db = pcall(require, "dashboard")
if not ok then
  return
end

db.custom_header = function()
  local header = {}
  for _ = 1,10 do
    table.insert(header, "")
  end
  table.insert(header, "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗")
  table.insert(header, "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║")
  table.insert(header, "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║")
  table.insert(header, "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║")
  table.insert(header, "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║")
  table.insert(header, "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝")
  for _ = 1,3 do
    table.insert(header, "")
  end
  return header
end
db.custom_footer = function()
  local count = #vim.tbl_keys(packer_plugins)
  return { "", "", "", "Happy Hacking 🎉 neovim loaded " .. count .. " plugins" }
end
db.custom_center = {
  {
    icon = "  ",
    desc = "Find file                               ",
    shortcut = "SPC f f",
    action = "lua require('xx.telescope').find_files()",
  },
  {
    icon = "  ",
    desc = "Frequently opened files                 ",
    shortcut = "SPC f o",
    action = "lua require('xx.telescope').oldfiles()",
  },
  {
    icon = "  ",
    desc = "Find word                               ",
    shortcut = "CTRL p ",
    action = "lua require('xx.telescope').live_grep()",
  },
  {
    icon = "  ",
    desc = "Recently saved session                  ",
    shortcut = "SPC s l",
    action = 'lua require("persistence").load({ last = true })',
  },
  {
    icon = "  ",
    desc = "Persional dotfiles                      ",
    shortcut = "SPC e d",
    action = "lua require('xx.telescope').edit_dotfiles()",
  },
  {
    icon = "  ",
    desc = "File browser                            ",
    shortcut = "SPC l f",
    action = "Lf",
  },
  {
    icon = "  ",
    desc = "Book marks                              ",
    shortcut = "SPC o m",
    action = "lua require('xx.telescope').marks()",
  },
  {
    icon = "  ",
    desc = "New file                                       ",
    action = "DashboardNewFile",
  },
}
