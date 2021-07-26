set commentstring=//\ %s
let b:switch_custom_definitions = [
\   {
\       '\(std::cout.*\)"\s*<<\s*''\\n'';': '\1\\n";',
\       '\(std::cout.*\)\\n";': '\1" << std::endl;',
\       '\(std::cout.*\)std::endl;': '\1''\\n'';',
\       '\<\(double\|int\|float\)\((.\+)\)': 'static_cast<\1>\2',
\       '^\(.\{-}\)/\*\(.\{-}\)\s*\*/': '\1//\2',
\       '^\(.\{-}\)//\(.\{-}\)\s*$': '\1/*\2 */',
\       '^#include\s*"\([^"]*\)"\s*': '#include <\1>',
\       '^#include\s*<\(.*\)>\s*': '#include "\1"'
\   }
\ ]
call coc#config('diagnostic.format', "%message\n[%source:%code]")

lua << EOF
require('xx.catkin').detect_package(function()
  vim.opt_local.colorcolumn = '121'
  require('xx.utils').set_indent(2)
  vim.b.ultisnips_cpp_style = 'ros'
end)
require('xx.catkin').detect_ws_root()
EOF

if !exists('b:ros_package_path')
  command! -buffer -nargs=0 A execute 'CocCommand clangd.switchSourceHeader'
endif
