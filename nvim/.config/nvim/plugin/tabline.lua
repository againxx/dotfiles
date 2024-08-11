vim.cmd [[
  nnoremap <A-,> <cmd>BufferPrevious<cr>
  nnoremap <A-.> <cmd>BufferNext<cr>
  nnoremap <A-<> <cmd>BufferMovePrevious<cr>
  nnoremap <A->> <cmd>BufferMoveNext<cr>
  nnoremap <A-1> <cmd>BufferGoto 1<cr>
  nnoremap <A-2> <cmd>BufferGoto 2<cr>
  nnoremap <A-3> <cmd>BufferGoto 3<cr>
  nnoremap <A-4> <cmd>BufferGoto 4<cr>
  nnoremap <A-5> <cmd>BufferGoto 5<cr>
  nnoremap <A-6> <cmd>BufferGoto 6<cr>
]]

require("barbar").setup {
  icons = {
    button = "",
    separator = {
      left = "▊",
    },
  },
  maximum_padding = 1,
  maximum_length = 40,
  sidebar_filetypes = {
    undotree = true,
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

wk.add {
  { "<leader>b", group = "buffer" },
  { "<leader>bb", "<cmd>BufferPick<cr>", desc = "Pick buffer" },
  -- sort automatically by
  { "<leader>bd", "<cmd>BufferOrderByDirectory<cr>", desc = "Sort buffer by directory" },
  { "<leader>bl", "<cmd>BufferOrderByLanguage<cr>", desc = "Sort buffer by language" },
  { "<leader>bp", "<cmd>BufferPin<cr>", desc = "Pin current buffer" },
  { "<leader>qa", close_all_but_current_or_pinned, desc = "Close all buffer but current/pinned" },
  { "<leader>qq", close_qf_first, desc = "Only close buffer" },
  { "<leader>qw", "<cmd>BufferWipeout!<cr>", desc = "Wipeout buffer" },
  { "[B", "<cmd>BufferGoto 1<cr>", desc = "Go to first buffer" },
  {
    "[b",
    function()
      goto_buf_in_other_win(-1)
    end,
    desc = "Go to previous buf in other win",
  },
  { "[t", "<cmd>tabprevious<cr>", desc = "Switch to previous tab" },
  { "]B", "<cmd>BufferGoto -1<cr>", desc = "Go to last buffer" },
  {
    "]b",
    function()
      goto_buf_in_other_win(1)
    end,
    desc = "Go to next buf in other win",
  },
  { "]t", "<cmd>tabnext<cr>", desc = "Switch to next tab" },
}
