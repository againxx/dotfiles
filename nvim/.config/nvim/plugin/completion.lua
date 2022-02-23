local lspkind = require "lspkind"
lspkind.init {
  symbol_map = {
    Function = "",
    Constructor = "",
    Variable = "",
    Snippet = "",
    Reference = "渚",
  },
}

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      -- vim.fn['UltiSnips#Anon'](args.body)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- vim.fn['UltiSnips#ExpandSnippet']()
      if luasnip.expand() then
        cmp.close()
      elseif cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
      else
        fallback()
      end
    end, { "i", "s", "c" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "c" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    -- Use <c-space> to trigger completion.
    ["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = 'ultisnips' },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "tmux" },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        path = "[path]",
        -- ultisnips = "[snip]",
        luasnip = "[snip]",
        tmux = "[tmux]",
        vimwiki_tags = "[tag]",
        spell = "[spell]",
      },
    },
  },
  documentation = {
    -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    winhighlight = "NormalFloat:CmpDocNormal",
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  mapping = {
    ["<c-n>"] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, {"i", "c"}),
    ["<c-p>"] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, {"i", "c"}),
  },
  sources = {
    { name = "buffer" },
  },
  view = {
    entries = { name = "wildmenu" },
  },
})

cmp.setup.cmdline(":", {
  mapping = {
    ["<c-n>"] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, {"i", "c"}),
    ["<c-p>"] = cmp.mapping(function(fallback)
      cmp.close()
      fallback()
    end, {"i", "c"}),
  },
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", keyword_length = 3 },
  }),
})
