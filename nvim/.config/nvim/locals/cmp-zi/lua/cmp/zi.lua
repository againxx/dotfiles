local Job = require "plenary.job"
local Path = require "plenary.path"
local curl = require "plenary.curl"
local types = require "cmp.types"
local uv = vim.loop
local source = {}

local bin_path = vim.env.HOME .. "/.config/nvim/locals/cmp-zi/target/release/cmp-zi"

if not vim.uv.fs_stat(bin_path) then
  return
end


function source:new(use_external)
  local obj = setmetatable({}, { __index = self })
  local data_path = Path:new(vim.fn.stdpath "data" .. "/cmp-zi/")
  if not data_path:exists() then
    data_path:mkdir()
  end
  local file_name = "ecdict.csv"
  obj.jobid = 0
  obj.dict_path = data_path:joinpath(file_name)
  if not obj.dict_path:exists() then
    local url = "https://raw.githubusercontent.com/skywind3000/ECDICT/master/ecdict.csv"
    curl.get(url, {
      output = obj.dict_path:absolute(),
      callback = function(res)
        if res.status ~= 200 then
          vim.notify(string.format("Download ecdict failed: error code %d!", res.status), vim.log.levels.ERROR)
        else
          vim.notify "Successfully download ecdict!"
        end
      end,
    })
  else
    vim.defer_fn(function()
      if use_external then
        obj:init_job()
      else
        obj:read_ecdict()
      end
    end, 500)
  end
  return obj
end

function source:init_job()
  if self.jobid == 0 then
    self.jobid = vim.fn.jobstart({ bin_path }, {
      rpc = true,
      on_stderr = function(_, data)
        vim.notify(data, vim.log.levels.ERROR)
      end,
    })
  end
  if self.jobid == 0 then
    vim.notify("cmp-zi: cannot start rpc process", vim.log.levels.ERROR)
  elseif self.jobid == -1 then
    vim.notify("cmp-zi: rpc process is not executable", vim.log.levels.ERROR)
  else
    vim.rpcrequest(self.jobid, "init", self.dict_path:absolute())
  end
end

local construct_completion_items = function(candidates, ecdict)
  local items = {}
  for _, w in ipairs(candidates) do
    local doc_str = ""
    if ecdict and ecdict[w] then
      local dict_item = ecdict[w]
      doc_str = string.format("# %s", w)
      if dict_item.phonetic:len() > 0 then
        doc_str = doc_str .. string.format("\n/%s/\n", dict_item.phonetic)
      end
      if dict_item.definition:len() > 0 then
        local defs = vim.split(dict_item.definition, "\\n", { plain = true })
        doc_str = doc_str .. "\n## English\n"
        for i, def in ipairs(defs) do
          doc_str = doc_str .. string.format("%d. %s\n", i, def)
        end
      end
      if dict_item.translation:len() > 0 then
        local trans = vim.split(dict_item.translation, "\\n", { plain = true })
        doc_str = doc_str .. string.format("\n## 中文\n", dict_item.translation)
        for i, tran in ipairs(trans) do
          doc_str = doc_str .. string.format("%d. %s\n", i, tran)
        end
      end
    else
      doc_str = string.format("# %s", w[1])
      if w[2]:len() > 0 then
        doc_str = doc_str .. string.format("\n/%s/\n", w[2])
      end
      if w[3]:len() > 0 then
        local defs = vim.split(w[3], "\\n", { plain = true })
        doc_str = doc_str .. "\n## English\n"
        for i, def in ipairs(defs) do
          doc_str = doc_str .. string.format("%d. %s\n", i, def)
        end
      end
      if w[4]:len() > 0 then
        local trans = vim.split(w[4], "\\n", { plain = true })
        doc_str = doc_str .. string.format("\n## 中文\n", w[4])
        for i, tran in ipairs(trans) do
          doc_str = doc_str .. string.format("%d. %s\n", i, tran)
        end
      end
      w = w[1]
    end
    table.insert(
      items,
      { label = w, documentation = {
        kind = types.lsp.MarkupKind.Markdown,
        value = doc_str,
      } }
    )
  end
  return { items = items, isIncomplete = false }
end

local convert_case = function(query, candidates)
  local upper_match = query:match "^%u+"
  if upper_match then
    local trans_fn
    if #upper_match > 1 then -- All capitals
      if type(candidates[1]) == "table" then
        trans_fn = function(candidate)
          return { candidate[1]:upper(), candidate[2], candidate[3], candidate[4] }
        end
      else
        trans_fn = string.upper
      end
    else -- capitalize the first letter
      if type(candidates[1]) == "table" then
        trans_fn = function(candidate)
          return { candidate[1]:sub(1, 1):upper() .. candidate[1]:sub(2), candidate[2], candidate[3], candidate[4] }
        end
      else
        trans_fn = function(candidate)
          return candidate:sub(1, 1):upper() .. candidate:sub(2)
        end
      end
    end
    return vim.tbl_map(trans_fn, candidates)
  end
  return candidates
end

function source:process_ecdict(data)
  local lines = vim.split(data, "\r\n", { plain = true })
  self.remained_data = table.remove(lines)
  for _, line in ipairs(lines) do
    local items = vim.split(line, ",", { plain = true })
    if #items > 13 then
      local quoted_strings = {}
      local new_items = {}
      for quoted in line:gmatch [["(.-)",]] do
        table.insert(quoted_strings, quoted)
      end

      local skip_mode = false
      local quoted_index = 1
      for _, item in ipairs(items) do
        if not skip_mode then
          if item:match [[^"]] then
            table.insert(new_items, quoted_strings[quoted_index])
            quoted_index = quoted_index + 1
            skip_mode = true
          else
            table.insert(new_items, item)
          end
        elseif item:match [["$]] then
          skip_mode = false
        end
        if #new_items >= 5 then
          items = new_items
          break
        end
      end
    end
    self.ecdict[items[1]:lower()] = {
      phonetic = items[2] or "",
      definition = items[3] or "",
      translation = items[4] or "",
      pos = items[5] or "",
    }
  end
end

function source:read_ecdict()
  self.ecdict = {}
  self.remained_data = ""
  self.count = 0
  local chunk_size = 256
  uv.fs_open(self.dict_path:absolute(), "r", tonumber("644", 8), function(err_open, fd)
    assert(not err_open, err_open)

    local read_cb
    read_cb = function(err_read, data)
      assert(not err_read, err_read)
      data = self.remained_data .. data
      if #data > 0 then
        self:process_ecdict(data)
        uv.fs_read(fd, chunk_size, nil, read_cb)
      else
        if #self.remained_data > 0 then
          self:process_ecdict(self.remained_data)
        end
        uv.fs_close(fd, function(err_close)
          assert(not err_close, err_close)
        end)
      end
    end

    uv.fs_read(fd, chunk_size, nil, read_cb)
  end)
end

function source:complete(request, callback)
  local query = string.sub(request.context.cursor_before_line, request.offset)
  local should_convert_case = request.option.convert_case
  local args
  local candidates = {}
  if not self.ecdict and self.jobid > 0 then
    candidates = vim.rpcrequest(self.jobid, "look", query:lower())
    if candidates ~= vim.NIL then
      if should_convert_case then
        candidates = convert_case(query, candidates)
      end
      callback(construct_completion_items(candidates))
    end
  else
    if request.option.dict then
      args = { "-f", "--", query, request.option.dict }
    else
      args = { "--", query }
    end
    Job
      :new({
        command = "look",
        args = args,
        on_stdout = function(err, word)
          if not err then
            table.insert(candidates, vim.trim(word))
          end
        end,
        on_exit = function()
          if should_convert_case then
            candidates = convert_case(query, candidates)
          end
          callback(construct_completion_items(candidates, self.ecdict))
        end,
      })
      :start()
  end
end

require("cmp").register_source("zi", source:new(true))
