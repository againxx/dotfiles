local signs = { Error = "->", Warn = "--", Hint = "··", Info = "--" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  ['[e'] = { '<cmd>lua vim.diagnostic.goto_prev{ severity = vim.diagnostic.severity.ERROR }<cr>', 'Go to previous error' },
  [']e'] = { '<cmd>lua vim.diagnostic.goto_next{ severity = vim.diagnostic.severity.ERROR }<cr>', 'Go to next error' },
  ['[w'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Go to previous diagnostic' },
  [']w'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Go to next diagnostic' },
})
