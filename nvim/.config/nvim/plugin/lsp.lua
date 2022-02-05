local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "rounded",
})

local has_lsp, lsp_installer_servers = pcall(require, "nvim-lsp-installer.servers")
if not has_lsp then
  return
end
local lsp_status = require "lsp-status"
lsp_status.config {}
lsp_status.register_progress()

local show_documentation = function()
  if vim.tbl_contains({ "vim", "lua" }, vim.bo.filetype) then
    if vim.bo.filetype == "lua" and not vim.fn.expand("<cWORD>"):match "vim%." then
      vim.lsp.buf.hover()
    else
      vim.cmd(string.format("h %s", vim.fn.expand "<cword>"))
    end
  else
    vim.lsp.buf.hover()
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_default = function(client, bufnr)
  lsp_status.on_attach(client)
  require("illuminate").on_attach(client)
  require("lsp_signature").on_attach()

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  end

  keymap.set("n", "K", show_documentation, vim.tbl_extend("force", opts, { buffer = bufnr }))

  local success, wk = pcall(require, "which-key")
  if not success then
    return
  end

  -- GoTo code navigation.
  wk.register({
    d = { "<cmd>lua require('xx.telescope').lsp_definitions()<cr>", "Go to definitions" },
    D = { "<cmd>lua vim.lsp.buf.delcaration()<cr>", "Go to definitions" },
    l = { "<cmd>lua require('xx.telescope').lsp_implementations()<cr>", "Go to implementations" },
    r = { "<cmd>lua require('xx.telescope').lsp_references()<cr>", "Go to references" },
    y = { "<cmd>lua require('xx.telescope').lsp_type_definitions()<cr>", "Go to type definitions" },
  }, { prefix = "g", buffer = vim.api.nvim_get_current_buf() })

  wk.register({
    r = {
      n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format the whole file" },
    },
    d = {
      g = { "<cmd>lua require('xx.telescope').diagnostics{bufnr = 0}<cr>", "Current buffer diagnostics" },
      G = { "<cmd>lua require('xx.telescope').diagnostics()<cr>", "Workspace diagnostics" },
    },
    os = { "<cmd>SymbolsOutline<cr>", "Symbols outline" },
  }, { prefix = "<leader>", buffer = vim.api.nvim_get_current_buf() })
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  pyright = true,
  rust_analyzer = true,
  clangd = require "xx.lsp.cpp",
  sumneko_lua = require "xx.lsp.lua",
  vimls = true,
  efm = require "xx.lsp.efm",
  bashls = true,
}

local setup_server = function(server_name, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  local on_attach
  if config.on_attach_extra then
    on_attach = function(client, bufnr)
      on_attach_default(client, bufnr)
      config.on_attach_extra(client, bufnr)
    end
  else
    on_attach = on_attach_default
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  local server_available, server = lsp_installer_servers.get_server(server_name)
  if server_available then
    server:on_ready(function()
      server:setup(config)
    end)
    if not server:is_installed() then
      server:install()
    end
  end
end

for server_name, config in pairs(servers) do
  setup_server(server_name, config)
end

vim.g.symbols_outline = {
  width = 35,
  preview_bg_highlight = 'NormalFloat',
}
