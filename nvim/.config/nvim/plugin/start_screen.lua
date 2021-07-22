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
    command = require('telescope.builtin').find_files
  },
  ['2_frecency'] = {
    description = { ' Frequently opened files                 SPC f o' },
    command = require('xx.telescope').oldfiles
  },
  ['3_find_word'] = {
    description = { ' Find word                               CTRL p ' },
    command = require('telescope').extensions.fzf_writer.staged_grep
  },
  ['4_last_session'] = {
    description = { ' Recently saved sessions                 SPC s r' },
    command = 'CocCommand session.load'
  },
  ['5_dotfiles'] = {
    description = { ' Persional dotfiles                      SPC e d' },
    command = require('xx.telescope').edit_dotfiles
  },
  ['6_file_browser'] = {
    description = { 'פּ File browser                            SPC r a' },
    command = 'RnvimrToggle'
  },
  ['7_marks'] = {
    description = { ' Book marks                              SPC o m' },
    command = require('telescope.builtin').marks
  },
  ['8_new_file'] = {
    description = { ' New file                                       ' },
    command = 'DashboardNewFile'
  },
}
