local lsp_status = require "lsp-status"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.offsetEncoding = { "utf-16" }

return {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=never",
  },
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
  },
  init_options = {
    clangdFileStatus = true,
  },
  handlers = lsp_status.extensions.clangd.setup(),
  capabilities = capabilities,
}
