-- After recent update from nvim-0.7.0, virtual_text = false
-- only takes effect in after folder
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

