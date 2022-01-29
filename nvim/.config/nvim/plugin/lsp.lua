local keymap = vim.keymap
local opts = { noremap=true, silent=true }
local has_lsp, lsp_installer_servers = pcall(require, "nvim-lsp-installer.servers")
if not has_lsp then
  return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', vim.tbl_extend("force", opts, { buffer = bufnr }))

  local success, wk = pcall(require, 'which-key')
  if not success then
    return
  end

  -- GoTo code navigation.
  wk.register({
    d = { "<cmd>lua require('xx.telescope').lsp_definitions()<cr>", 'Go to definitions' },
    D = { "<cmd>lua vim.lsp.buf.delcaration()<cr>", 'Go to definitions' },
    l = { "<cmd>lua require('xx.telescope').lsp_implementations()<cr>", 'Go to implementations' },
    r = { "<cmd>lua require('xx.telescope').lsp_references()<cr>", 'Go to references' },
    y = { "<cmd>lua require('xx.telescope').lsp_type_definitions()<cr>", 'Go to type definitions' },
    q = { '<Plug>(coc-format-selected)', 'Format by motion' },
    qq = { '<Plug>(coc-format-selected)j', 'Format current line' },
  }, { prefix = 'g', buffer = vim.api.nvim_get_current_buf() })

  wk.register({
    r = {
      n = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol' },
    },
  }, { prefix = '<leader>', buffer = vim.api.nvim_get_current_buf() })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  pyright = true,
  rust_analyzer = true,
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=never",
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

local setup_server = function(server_name, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
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
    server:on_ready(function ()
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

local signs = { Error = "->", Warn = "--", Hint = "··", Information = "--" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
