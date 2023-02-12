local signs = { Error = "->", Warn = "--", Hint = "··", Info = "--" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register {
  ["[e"] = {
    function()
      require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
    end,
    "Go to previous error",
  },
  ["]e"] = {
    function()
      require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
    end,
    "Go to next error",
  },
  ["[w"] = {
    function()
      -- Trigger the autocmds for CursorMoved otherwise the previous diagnostic
      -- window won't be closed when we press [w for several times
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_prev()
    end,
    "Go to previous diagnostic",
  },
  ["]w"] = {
    function()
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_next()
    end,
    "Go to next diagnostic",
  },
}
