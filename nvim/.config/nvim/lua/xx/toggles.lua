local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local M = {}

function M.toggle_error_code()
  if fn['coc#util#get_config']('diagnostic').format == '%message\n[%source]' then
    fn['coc#config']('diagnostic.format', '%message\n[%source:%code]')
  else
    fn['coc#config']('diagnostic.format', '%message\n[%source]')
  end
end

function M.change_diagnostic_level()
  if fn['coc#util#get_config']('diagnostic').level == 'warning' then
    fn['coc#config']('diagnostic.level', 'hint')
  else
    fn['coc#config']('diagnostic.level', 'warning')
  end
  fn.CocActionAsync('diagnosticRefresh', api.nvim_get_current_buf())
end

function M.toggle_code_lens()
  if fn['coc#util#get_config']('codeLens').enable > 0 then
    fn['coc#config']('codeLens.enable', 0)
  else
    fn['coc#config']('codeLens.enable', 1)
  end
  if vim.bo.filetype == 'rust' then
    cmd('CocCommand rust-analyzer.toggleInlayHints')
  end
end

function M.toggle_git_blame()
  if fn['coc#util#get_config']('git').addGBlameToVirtualText then
    fn['coc#config']('git.addGBlameToVirtualText', false)
    local ns_id = api.nvim_get_namespaces()['coc-git-virtual']
    api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
  else
    fn['coc#config']('git.addGBlameToVirtualText', true)
  end
end

function M.toggle_diagnostic()
  if vim.b.coc_diagnostic_disable and vim.b.coc_diagnostic_disable > 0 then
    vim.b.coc_diagnostic_disable = 0
  else
    vim.b.coc_diagnostic_disable = 1
  end
  cmd('doautocmd BufEnter')
end

function M.toggle_left_equation()
  local options = vim.g.mkdp_preview_options
  if options.katex and options.katex.fleqn then
    if options.katex.fleqn == 1 then
      options.katex.fleqn = 0
    else
      options.katex.fleqn = 1
    end
  else
    options.katex = { fleqn = 1 }
  end
  vim.g.mkdp_preview_options = options
end

return M
