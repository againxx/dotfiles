local keymap = vim.keymap
local opts = { noremap = true, silent = true, expr = true, buffer = vim.api.nvim_get_current_buf() }

if vim.g.defx_open_in_vertical_split then
  keymap.set('n', 'l', "defx#do_action('open', 'choose')", opts)
else
  keymap.set('n', 'l', "defx#do_action('open')", opts)
end
keymap.set('n', '<cr>', "defx#do_action('open')", opts)
keymap.set('n', 'yy', "defx#do_action('copy')", opts)
keymap.set('n', 'dd', "defx#do_action('move')", opts)
keymap.set('n', 'p', "defx#do_action('paste')", opts)
keymap.set('n', '<c-v>', "defx#do_action('open', 'vsplit)", opts)
keymap.set('n', 'P', "defx#do_action('preview')", opts)
keymap.set('n', 'o', "defx#do_action('open_tree', 'toggle')", opts)
keymap.set('n', 'O', "defx#do_action('open_tree', ['toggle', 'recursive'])", opts)
keymap.set('n', 'a', "defx#do_action('new_file')", opts)
keymap.set('n', 'A', "defx#do_action('new_directory')", opts)
keymap.set('n', 'cw', "defx#do_action('rename')", opts)
keymap.set('n', 'yp', "defx#do_action('yank_path')", opts)
keymap.set('n', 'dt', "defx#do_action('remove_trash')", opts)
keymap.set('n', 'df', "defx#do_action('remove')", opts)
keymap.set('n', 'h', "defx#do_action('cd', ['..'])", opts)
keymap.set('n', '~', "defx#do_action('cd')", opts)
keymap.set('n', 'q', "defx#do_action('quit')", opts)
keymap.set('n', '<c-p>', "defx#do_action('toggle_select') . 'k'", opts)
keymap.set('n', '<c-n>', "defx#do_action('toggle_select') . 'j'", opts)
keymap.set('n', '<c-l>', "defx#do_action('toggle_select')", opts)
keymap.set('n', 'v', "defx#do_action('toggle_select_all')", opts)
keymap.set('n', 'j', "line('.') == line('$') ? 'gg' : 'j'", opts)
keymap.set('n', 'k', "line('.') == 1 ? 'G' : 'k'", opts)
keymap.set('n', '<c-h>', "defx#do_action('toggle_ignored_files')", opts)
keymap.set('n', '<c-g>', "defx#do_action('print')", opts)
keymap.set('n', '<m-l>', "defx#do_action('redraw')", opts)
keymap.set('n', ';', "defx#do_action('repeat')", opts)
keymap.set('n', '!', "defx#do_action('execute_command')", opts)
keymap.set('n', 'cd', "defx#do_action('change_vim_cwd')", opts)


if vim.o.guicursor ~= "a:DefxCursorHiddenCursor" then
  _G.DefxSavedCursor = vim.o.guicursor
end
vim.o.guicursor = "a:DefxCursorHiddenCursor"
vim.wo.cursorline = true
vim.cmd [[
  autocmd BufEnter <buffer> lua vim.o.guicursor = "a:DefxCursorHiddenCursor"
  autocmd BufLeave <buffer> lua vim.o.guicursor = _G.DefxSavedCursor
  autocmd BufHidden <buffer> lua require'bufferline.state'.set_offset(0); vim.g.defx_open_in_vertical_split = false
]]
