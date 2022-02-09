vim.g.dashboard_custom_header = {
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

vim.g.dashboard_custom_footer = { 'Happy Hacking' }
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
  ['1_find_files'] = {
    description = { ' Find file                               SPC f f' },
    command = "lua require('xx.telescope').find_files()"
  },
  ['2_frecency'] = {
    description = { ' Frequently opened files                 SPC f o' },
    command = "lua require('xx.telescope').oldfiles()"
  },
  ['3_find_word'] = {
    description = { ' Find word                               CTRL p ' },
    command = "lua require('xx.telescope').live_grep()"
  },
  ['4_last_session'] = {
    description = { ' Recently saved session                  SPC s l' },
    command = 'lua require("persistence").load({ last = true })'
  },
  ['5_dotfiles'] = {
    description = { ' Persional dotfiles                      SPC e d' },
    command = "lua require('xx.telescope').edit_dotfiles()"
  },
  ['6_file_browser'] = {
    description = { ' File browser                            SPC r a' },
    command = 'RnvimrToggle'
  },
  ['7_marks'] = {
    description = { ' Book marks                              SPC o m' },
    command = "lua require('xx.telescope').marks()"
  },
  ['8_new_file'] = {
    description = { ' New file                                       ' },
    command = 'DashboardNewFile'
  },
}
