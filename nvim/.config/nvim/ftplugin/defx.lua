local keymap = vim.keymap
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, expr = true, buffer = bufnr }

if vim.g.defx_open_in_vertical_split then
  -- automatically quit when use choose
  keymap.set('n', 'l', [=[
      defx#is_directory() ? defx#do_action('open_directory') : defx#do_action('multi', [['open', 'choose'], 'quit'])
    ]=], opts)
  keymap.set('n', '<cr>', "defx#do_action('drop')", opts)
else
  keymap.set('n', 'l', "defx#do_action('open')", opts)
  keymap.set('n', '<cr>', "defx#do_action('open')", opts)
end
keymap.set('n', 'yy', "defx#do_action('copy')", opts)
keymap.set('n', 'dd', "defx#do_action('move')", opts)
keymap.set('n', 'p', "defx#do_action('paste')", opts)
keymap.set('n', '<c-v>', "defx#do_action('open', 'vsplit)", opts)
keymap.set('n', '<c-x>', "defx#do_action('open', 'split)", opts)
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
keymap.set('n', 'R', "defx#do_action('redraw')", opts)
keymap.set('n', ';', "defx#do_action('repeat')", opts)
keymap.set('n', '!', "defx#do_action('execute_command')", opts)
keymap.set('n', 'cd', "defx#do_action('change_vim_cwd')", opts)


if vim.o.guicursor ~= "n:DefxCursorHiddenCursor" then
  _G.DefxSavedCursor = vim.o.guicursor
end

local setup_cursor = function()
  vim.o.guicursor = "n:DefxCursorHiddenCursor"
  vim.cmd [[hi CursorLine guibg=#4c6482]]
  vim.wo.cursorline = true
end
setup_cursor()

vim.api.nvim_create_autocmd("BufEnter", {
  buffer = bufnr,
  callback = setup_cursor,
})

vim.api.nvim_create_autocmd("BufLeave", {
  buffer = bufnr,
  callback = function()
    vim.o.guicursor = _G.DefxSavedCursor
    vim.cmd [[hi CursorLine guibg=#191e2a]]
  end
})

vim.api.nvim_create_autocmd("BufHidden", {
  buffer = bufnr,
  callback = function()
    require'bufferline.state'.set_offset(0); vim.g.defx_open_in_vertical_split = false
  end
})
