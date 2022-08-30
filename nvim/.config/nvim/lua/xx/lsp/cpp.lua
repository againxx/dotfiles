-- local lsp_status = require "lsp-status"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require "lspconfig"

-- Notably _not_ including `compile_commands.json`, as we want the entire project
local root_pattern = lspconfig.util.root_pattern ".git"

-- Might be cleaner to try to expose this as a pattern from `lspconfig.util`, as
-- really it is just stolen from part of the `clangd` config
local function project_name_to_container_name()
  -- Turn the name of the current file into the name of an expected container, assuming that
  -- the container running/building this file is named the same as the basename of the project
  -- that the file is in
  --
  -- The name of the current buffer
  local bufname = vim.api.nvim_buf_get_name(0)

  -- Turned into a filename
  local filename = lspconfig.util.path.is_absolute(bufname) and bufname
    or lspconfig.util.path.join(vim.loop.cwd(), bufname)

  -- Then the directory of the project
  local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)

  -- And finally perform what is essentially a `basename` on this directory
  local git_dir = lspconfig.util.find_git_ancestor(project_dirname)
  if git_dir and git_dir:sub(-1) == '/' then
    git_dir = git_dir:sub(1, -2)
  end
  return vim.fn.fnamemodify(git_dir, ":t")
end

return {
  cmd = {
    "cclangd",
    project_name_to_container_name(),
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=never",
    "--path-mappings=" .. vim.env.HOME .. "/Projects=/home/administrator/workspace",
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
  -- handlers = lsp_status.extensions.clangd.setup(),
  capabilities = capabilities,
}
