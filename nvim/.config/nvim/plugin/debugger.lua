local goto_and_maximize = function(win_id)
  vim.fn.win_gotoid(win_id)
  vim.api.nvim_command('MaximizerToggle!')
end

local wk = require('which-key')
wk.register({
  name = "+debugger/diagnostic",
  d = { '<cmd>call vimspector#Launch()<cr>', 'Start' },
  q = { '<cmd>call vimspector#Reset()<cr>', 'Stop' },
  x = { '<cmd>call vimspector#ClearBreakpoints()<cr>', 'Clear all breakpoints' },
  c = { function() goto_and_maximize(vim.g.vimspector_session_windows.code) end, 'Browse code' },
  v = { function() goto_and_maximize(vim.g.vimspector_session_windows.variables) end, 'Browse variables' },
  w = { function() goto_and_maximize(vim.g.vimspector_session_windows.watches) end, 'Browse watches' },
  s = { function() goto_and_maximize(vim.g.vimspector_session_windows.stack_trace) end, 'Browse stack trace' },
  o = { function() goto_and_maximize(vim.g.vimspector_session_windows.output) end, 'Browse output' },
  l = { '<Plug>VimspectorStepInto', 'Step into' },
  j = { '<Plug>VimspectorStepOver', 'Step over' },
  k = { '<Plug>VimspectorStepOut', 'Step out' },
  h = { '<Plug>VimspectorRunToCursor', 'Run to cursor' },
  r = { '<Plug>VimspectorRestart', 'Restart' },
  e = { '<Plug>VimspectorContinue', 'Continue' },
  i = { '<Plug>VimspectorToggleConditionalBreakpoint', 'Toggle conditional breakpoint' },
  [';'] = { '<Plug>VimspectorToggleBreakpoint', 'Toggle breakpoint' },
}, { prefix = '<leader>d' })

vim.g.vimspector_sign_priority = {
  vimspectorBP = 40,
  vimspectorBPCond = 40,
  vimspectorBPDisabled = 40,
  vimspectorPC = 999,
  vimspectorPCBP = 999,
}
vim.cmd[[
  sign define vimspectorBP     text=\ ● texthl=VimspectorBP
  sign define vimspectorBPCond text=\ ◐ texthl=VimspectorBPCond
  sign define vimspectorPC     text=\  texthl=VimspectorPC linehl=CursorLine
  sign define vimspectorPCBP   text=●▶  texthl=VimspectorPCBP linehl=CursorLine
]]
