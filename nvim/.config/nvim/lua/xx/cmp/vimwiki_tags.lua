local types = require('cmp.types')

local THROTTLE_TIMEOUT = 5000
local source = {}
source.cache = {}

function source:is_available()
  return vim.bo.filetype == "vimwiki"
end

function source:get_debug_name()
  return "vimwiki_tags"
end

function source:get_trigger_characters()
  return { ":" }
end

function source:complete(request, callback)
  if request.completion_context.triggerCharacter == ':'
    and request.completion_context.triggerKind == types.lsp.CompletionTriggerKind.TriggerCharacter then
    local wiki_nr = vim.fn["vimwiki#vars#get_bufferlocal"]('wiki_nr')
    if self.cache[wiki_nr] and vim.loop.now() - self.cache[wiki_nr].last_fetch_time < THROTTLE_TIMEOUT then
      callback(self.cache[wiki_nr].tags)
    else
      self.cache[wiki_nr] = self.cache[wiki_nr] or {}
      local current_cache = self.cache[wiki_nr]
      local tags = vim.fn["vimwiki#tags#get_tags"]()
      current_cache.last_fetch_time = vim.loop.now()
      current_cache.tags = {}
      for _, tag in ipairs(tags) do
        table.insert(current_cache.tags, { label = tag })
      end
      callback(current_cache.tags)
    end
  end
end

require('cmp').register_source("vimwiki_tags", source)
