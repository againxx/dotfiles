local switch_definitions = [==[
  let b:switch_custom_definitions = [
    {
      '\(std::cout.*\)"\s*<<\s*''\\n'';': '\1\\n";',
      '\(std::cout.*\)\\n";': '\1" << std::endl;',
      '\(std::cout.*\)std::endl;': '\1''\\n'';',
      '\<\(double\|int\|float\)\((.\+)\)': 'static_cast<\1>\2',
      '^\(.\{-}\)/\*\(.\{-}\)\s*\*/': '\1//\2',
      '^\(.\{-}\)//\(.\{-}\)\s*$': '\1/*\2 */',
      '^#include\s*"\([^"]*\)"\s*': '#include <\1>',
      '^#include\s*<\(.*\)>\s*': '#include "\1"'
    }
  ]
]==]
vim.cmd(switch_definitions:gsub('\n', ''))


vim.defer_fn(function()
  require('xx.catkin').detect_package(function()
    vim.opt_local.colorcolumn = '121'
    require('xx.utils').set_indent(2)
    vim.b.luasnip_cpp_style = 'ros'
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ri', '<cmd>AsyncTask catkin-init<cr>', { noremap = true, silent = true })
  end)
  require('xx.catkin').detect_ws_root()
end, 500)

if not vim.b.ros_package_path then
  vim.cmd [[command! -buffer -nargs=0 A execute 'ClangdSwitchSourceHeader']]
end
