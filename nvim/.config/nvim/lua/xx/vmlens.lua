local M = {}
local hlslens = require "hlslens"
local config
local lens_bak

local override_lens = function(render, pos_list, nearest, idx, rel_idx)
  local _ = rel_idx
  local lnum, col = unpack(pos_list[idx])

  local text, chunks
  if nearest then
    text = ('[%d/%d]'):format(idx, #pos_list)
    chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
  else
    text = ('[%d]'):format(idx)
    chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
  end
  render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
end

function M.start()
  if hlslens then
    config = require "hlslens.config"
    lens_bak = config.override_lens
    config.override_lens = override_lens
    hlslens.start(true)
  end
end

function M.exit()
  if hlslens then
    config.override_lens = lens_bak
    hlslens.start(true)
  end
end

return M
