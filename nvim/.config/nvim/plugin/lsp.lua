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

local saga = require "lspsaga"
saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  code_action_icon = " ",
  code_action_prompt = {
    virtual_text = false,
    sign_priority = 10,
  },
}

function vim.lsp.modified_formatexpr()
  local timeout_ms = 1000

  if vim.tbl_contains({ "i", "R", "ic", "ix" }, vim.fn.mode()) then
    -- `formatexpr` is also called when exceeding `textwidth` in insert mode
    -- fall back to internal formatting
    return 1
  end

  local start_line = vim.v.lnum
  local end_line = start_line + vim.v.count - 1

  if start_line > 0 and end_line > 0 then
    local params = {
      textDocument = vim.lsp.util.make_text_document_params(),
      range = {
        start = { line = start_line - 1, character = 0 },
        ["end"] = { line = end_line - 1, character = 0 },
      },
    }
    params.options = vim.lsp.util.make_formatting_params().options
    local client_results = vim.lsp.buf_request_sync(0, "textDocument/rangeFormatting", params, timeout_ms)

    -- Apply the text edits from one and only one of the clients.
    for _, response in pairs(client_results) do
      if response.result then
        if vim.bo.filetype == "cpp" then
          -- clangd use "utf-8" for range formatting
          -- even if we set it to "utf-16"
          vim.lsp.util.apply_text_edits(response.result, 0, "utf-16")
        else
          vim.lsp.util.apply_text_edits(response.result, 0)
        end
        return 0
      end
    end
  end
end

local show_documentation = function()
  if vim.tbl_contains({ "vim", "lua" }, vim.bo.filetype) then
    if vim.bo.filetype == "lua" and not vim.fn.expand("<cWORD>"):match "vim%." then
      require("lspsaga.hover").render_hover_doc()
    else
      vim.cmd(string.format("h %s", vim.fn.expand "<cword>"))
    end
  elseif vim.tbl_contains({ "rust", "cpp" }, vim.bo.filetype) then
    -- use rust-tools hover for extra code actions
    vim.lsp.buf.hover()
  else
    require("lspsaga.hover").render_hover_doc()
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_default = function(client, bufnr)
  lsp_status.on_attach(client)
  require("illuminate").on_attach(client)
  require("lsp_signature").on_attach()

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.modified_formatexpr()")
  end

  keymap.set("n", "K", show_documentation, vim.tbl_extend("force", opts, { buffer = bufnr }))

  local success, wk = pcall(require, "which-key")
  if not success then
    return
  end

  -- GoTo code navigation.
  wk.register({
    d = { "<cmd>lua require('xx.telescope').lsp_definitions()<cr>", "Go to definitions" },
    D = { "<cmd>lua vim.lsp.buf.delcaration()<cr>", "Go to delcarations" },
    h = { "<cmd>Lspsaga preview_definition<cr>", "Preview definitions" },
    l = { "<cmd>lua require('xx.telescope').lsp_implementations()<cr>", "Go to implementations" },
    r = { "<cmd>lua require('xx.telescope').lsp_references()<cr>", "Go to references" },
    y = { "<cmd>lua require('xx.telescope').lsp_type_definitions()<cr>", "Go to type definitions" },
  }, { prefix = "g", buffer = vim.api.nvim_get_current_buf() })

  wk.register({
    r = {
      n = { "<cmd>Lspsaga rename<cr>", "Rename symbol" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format the whole file" },
    },
    d = {
      g = { "<cmd>lua require('xx.telescope').diagnostics{bufnr = 0}<cr>", "Current buffer diagnostics" },
      G = { "<cmd>lua require('xx.telescope').diagnostics()<cr>", "Workspace diagnostics" },
    },
    os = { "<cmd>SymbolsOutline<cr>", "Symbols outline" },
    a = {
      name = "+action",
      a = { "<cmd>Lspsaga code_action<cr>", "Action under cursor" },
    },
  }, { prefix = "<leader>", buffer = vim.api.nvim_get_current_buf() })

  wk.register({
    a = { ":<C-u>Lspsaga range_code_action<cr>", "Action for selected" },
  }, { mode = "x", prefix = "<leader>" })
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
      if server.name == "rust_analyzer" then
        local extension_path = vim.env.HOME .. "/Manually_Installed/codelldb-x86_64-linux/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        -- initialize the LSP via rust-tools instead
        require("rust-tools").setup {
          tools = {
            runnables = {
              telescope = true,
            },
            inlay_hints = {
              parameter_hints_prefix = " ",
              other_hints_prefix = " ",
              highlight = "LspInlayHint",
            },
          },
          dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
          },
          server = vim.tbl_deep_extend("force", server:get_default_options(), config),
        }
        server:attach_buffers()
      elseif server.name == "clangd" then
        require("clangd_extensions").setup {
          extensions = {
            inlay_hints = {
              parameter_hints_prefix = " ",
              other_hints_prefix = " ",
              highlight = "LspInlayHint",
            },
          },
          server = vim.tbl_deep_extend("force", server:get_default_options(), config),
        }
      else
        server:setup(config)
      end
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
  preview_bg_highlight = "NormalFloat",
}
