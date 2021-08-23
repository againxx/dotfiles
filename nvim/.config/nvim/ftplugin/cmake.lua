vim.defer_fn(function()
  require('xx.catkin').detect_package(function()
    require('xx.utils').set_indent(2)
  end)
  require('xx.catkin').detect_ws_root()
end, 500)

vim.b.switch_custom_definitions = {
  vim.fn['switch#NormalizedCaseWords']({'on', 'off'}),
  vim.fn['switch#NormalizedCaseWords']({'yes', 'no'}),
}
