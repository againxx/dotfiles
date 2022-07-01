local keymap = vim.keymap
keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<cr>")
keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>")
keymap.set("n", "<A-<>", "<cmd>BufferLineMovePrev<cr>")
keymap.set("n", "<A->>", "<cmd>BufferLineMoveNext<cr>")
keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>")
keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>")
keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>")
keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>")
keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>")
keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>")

require("bufferline").setup {
  options = {
    indicator_icon = '',
    separator_style = "thick",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}

local close_qf_first = function()
  local quickfix_win = vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")
  if vim.fn.empty(quickfix_win) == 0 then
    vim.cmd "cclose"
    vim.cmd "lclose"
  else
    vim.cmd "BufferClose"
  end
end

local close_all_but_current_or_pinned = function()
  local state = require "bufferline.state"
  local buffers = state.buffers
  for _, number in ipairs(buffers) do
    if state.is_pinned(number) then
      vim.cmd "BufferCloseAllButPinned"
      return
    end
  end
  vim.cmd "BufferCloseAllButCurrent"
end

local goto_buf_in_other_win = function(steps)
  local state = require "bufferline.state"
  local index_of = require("bufferline.utils").index_of
  state.get_updated_buffers()
  vim.cmd "wincmd p"
  local previous_win = vim.api.nvim_get_current_win()
  vim.cmd "wincmd p"
  local current = vim.api.nvim_win_get_buf(previous_win)
  local idx = index_of(state.buffers, current)

  if idx == nil then
    print("Couldn't find buffer " .. current .. " in the list: " .. vim.inspect(state.buffers))
    return
  else
    idx = (idx + steps - 1) % #state.buffers + 1
  end

  vim.api.nvim_win_set_buf(previous_win, state.buffers[idx])
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register {
  ["[b"] = {
    function()
      goto_buf_in_other_win(-1)
    end,
    "Go to previous buf in other win",
  },
  ["]b"] = {
    function()
      goto_buf_in_other_win(1)
    end,
    "Go to next buf in other win",
  },
  ["[t"] = { "<cmd>tabprevious<cr>", "Switch to previous tab" },
  ["]t"] = { "<cmd>tabnext<cr>", "Switch to next tab" },
  ["<leader>qq"] = { close_qf_first, "Only close buffer" },
  ["<leader>qw"] = { "<cmd>BufferWipeout!<cr>", "Wipeout buffer" },
  ["<leader>qa"] = { close_all_but_current_or_pinned, "Close all buffer but current/pinned" },
  ["<leader>b"] = {
    name = "+buffer",
    b = { "<cmd>BufferLinePick<cr>", "Pick buffer" },
    -- sort automatically by
    d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort buffer by directory" },
    l = { "<cmd>BufferLineSortByExtension<cr>", "Sort buffer by language" },
    p = { "<cmd>BufferLineTogglePin<cr>", "Pin current buffer" },
  },
}
