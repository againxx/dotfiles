local signs = { Error = "->", Warn = "--", Hint = "··", Info = "--" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = false,
  severity_sort = true,
  float = {
    focusable = false,
    source = true,
    scope = "cursor",
    header = "",
    border = "rounded",
  },
}

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.add {
  {
    "[e",
    function()
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
    end,
    desc = "Go to previous error",
  },
  {
    "]e",
    function()
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
    end,
    desc = "Go to next error",
  },
  {
    "[w",
    function()
      -- Trigger the autocmds for CursorMoved otherwise the previous diagnostic
      -- window won't be closed when we press [w for several times
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_prev()
    end,
    desc = "Go to previous diagnostic",
  },
  {
    "]w",
    function()
      vim.cmd.doautocmd "CursorMoved"
      require("lspsaga.diagnostic"):goto_next()
    end,
    desc = "Go to next diagnostic",
  },
}
