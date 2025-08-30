local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local keymap = vim.keymap

keymap.del('n', 'grn')
keymap.del({'n', 'v'}, 'gra')
keymap.del('n', 'grr')
keymap.del('n', 'gri')

require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = true,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "rounded",
})

require("lspsaga").setup {
  ui = {
    code_action = " ",
  },
  lightbulb = {
    virtual_text = false,
  },
  diagnostic = {
    on_insert = false,
  },
}

require("clangd_extensions").setup {
  inlay_hints = {
    parameter_hints_prefix = " ",
    other_hints_prefix = " ",
    highlight = "LspInlayHint",
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
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "lua" }, filetype) then
    if filetype == "lua" and not vim.fn.expand("<cWORD>"):match "vim%." then
      require("lspsaga.hover"):render_hover_doc()
    else
      vim.cmd(string.format("h %s", vim.fn.expand "<cword>"))
    end
  elseif vim.tbl_contains({ "rust", "cpp" }, filetype) then
    -- use rust-tools hover for extra code actions
    vim.lsp.buf.hover()
  else
    require("lspsaga.hover"):render_hover_doc()
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_default = function(client, bufnr)
  require("illuminate").on_attach(client)
  require("lsp_signature").on_attach {
    hint_prefix = "🐯 ",
  }
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navbuddy").attach(client, bufnr)
  end

  keymap.set("n", "K", show_documentation, { silent = true, buffer = bufnr })

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.modified_formatexpr()", { buf = bufnr })
  end

  local success, wk = pcall(require, "which-key")
  if not success then
    return
  end

  -- GoTo code navigation.
  wk.add {
    {
      "gd",
      "<cmd>lua require('xx.telescope').lsp_definitions()<cr>",
      desc = "Go to definitions",
      -- buffer = bufnr,
    },
    {
      "gD",
      "<cmd>lua vim.lsp.buf.delcaration()<cr>",
      desc = "Go to delcarations",
      buffer = bufnr,
    },
    { "gh", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definitions", buffer = bufnr },
    {
      "gl",
      "<cmd>lua require('xx.telescope').lsp_implementations()<cr>",
      desc = "Go to implementations",
      buffer = bufnr,
    },
    {
      "gr",
      "<cmd>lua require('xx.telescope').lsp_references()<cr>",
      desc = "Go to references",
      buffer = bufnr,
    },
    {
      "gy",
      "<cmd>lua require('xx.telescope').lsp_type_definitions()<cr>",
      desc = "Go to type definitions",
      buffer = bufnr,
    },
  }

  wk.add {
    { "<leader>a", group = "action" },
    { "<leader>aa", "<cmd>Lspsaga code_action<cr>", desc = "Action under cursor", buffer = bufnr },
    {
      "<leader>dG",
      "<cmd>lua require('xx.telescope').diagnostics()<cr>",
      desc = "Workspace diagnostics",
      buffer = bufnr,
    },
    {
      "<leader>dg",
      "<cmd>lua require('xx.telescope').diagnostics{bufnr = 0}<cr>",
      desc = "Current buffer diagnostics",
      buffer = bufnr,
    },
    { "<leader>os", "<cmd>SymbolsOutline<cr>", desc = "Symbols outline", buffer = bufnr },
    { "<leader>rf", "<cmd>lua vim.lsp.buf.format{async = true}<cr>", desc = "Format the whole file", buffer = bufnr },
    { "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", desc = "Rename symbol", buffer = bufnr },
  }

  wk.add {
    mode = { "x" },
    { "<leader>a", "<cmd>Lspsaga range_code_action<cr>", desc = "Action for selected" },
    { "<leader>n", "<cmd>lua require('renamer').rename()<cr>", desc = "Rename symbol" },
  }
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
    -- flags = { -- figure out why we don't need debounce_text_changes
    --   debounce_text_changes = nil,
    -- },
  }, config)

  if server_name == "rust_analyzer" then
    local extension_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/") or ""
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    -- initialize the LSP via rust-tools instead
    require("rust-tools").setup {
      tools = {
        inlay_hints = {
          parameter_hints_prefix = " ",
          other_hints_prefix = " ",
          highlight = "LspInlayHint",
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
      server = config,
    }
  else
    lspconfig[server_name].setup(config)
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  pyright = true,
  rust_analyzer = require "xx.lsp.rust",
  clangd = require "xx.lsp.cpp",
  lua_ls = require "xx.lsp.lua",
  vimls = true,
  efm = require "xx.lsp.efm",
  bashls = true,
  hls = false,
  cmake = true,
  dockerls = true,
  ltex = require "xx.lsp.ltex",
  gopls = true,
  -- starlark_rust = true,
}

for server_name, config in pairs(servers) do
  setup_server(server_name, config)
end

require("fidget").setup {
  notification = {
    window = {
      winblend = 0,
    },
  },
  progress = {
    display = {
      progress_icon = { "moon" },
      progress_style = "Todo",
    },
  },
}

require("renamer").setup {
  mappings = {
    ["<M-h>"] = function()
      vim.api.nvim_input "<left>"
    end,
    ["<M-l>"] = function()
      vim.api.nvim_input "<right>"
    end,
    ["<C-b>"] = function()
      require("renamer.mappings.utils").set_cursor_to_start()
    end,
    ["<C-e>"] = function()
      require("renamer.mappings.utils").set_cursor_to_end()
    end,
  },
}
