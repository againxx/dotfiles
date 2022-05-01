local Job = require "plenary.job"
local Path = require "plenary.path"
local curl = require "plenary.curl"
local uv = vim.loop
local source = {}

function source:new()
  local obj = setmetatable({}, { __index = self })
  local data_path = Path:new(vim.fn.stdpath "data" .. "/cmp-zi/")
  if not data_path:exists() then
    data_path:mkdir()
  end
  local file_name = "ecdict.csv"
  local dict_path = data_path:joinpath(file_name)
  if not dict_path:exists() then
    local url = "https://raw.githubusercontent.com/skywind3000/ECDICT/master/ecdict.csv"
    curl.get(url, {
      output = dict_path:absolute(),
      callback = function(res)
        if res.status ~= 200 then
          vim.notify(string.format("Download ecdict failed: error code %d!", res.status), vim.log.levels.ERROR)
        else
          vim.notify("Successfully download ecdict!", vim.log.levels.INFO)
        end
        uv.new_thread(source.read_ecdict, obj, dict_path)
      end,
    })
  end
  uv.new_thread(function() source.read_ecdict(obj, dict_path) end)
  return obj
end

local construct_completion_items = function(candidates)
  local items = {}
  for _, w in ipairs(candidates) do
    table.insert(items, { label = w })
  end
  return { items = items, isIncomplete = true }
end

local convert_case = function(query, candidates)
  local upper_match = query:match "^%u+"
  if upper_match then
    if #upper_match > 1 then -- All capitals
      return vim.tbl_map(string.upper, candidates)
    else -- capitalize the first letter
      return vim.tbl_map(function(word)
        return word:sub(1, 1):upper() .. word:sub(2)
      end, candidates)
    end
  end
  return candidates
end

function source:read_ecdict(path)
  path:read(function(data)
    self.ecdict = {}
    local lines = vim.split(data, "\r*\n")
    table.remove(lines, 1) -- remove the header
    for _, line in ipairs(lines) do
      local items = vim.split(line, ",")
      self.ecdict[items[1]:lower()] = {
        phonetic = items[2] or '',
        definition = items[3] or '',
        translation = items[4] or '',
        pos = items[5] or '',
      }
    end
    P(self.ecdict.success)
  end)
end

function source:complete(request, callback)
  local query = string.sub(request.context.cursor_before_line, request.offset)
  local should_convert_case = request.option.convert_case
  local args
  local candidates = {}
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
        callback(construct_completion_items(candidates))
      end,
    })
    :start()
end

require("cmp").register_source("zi", source:new())
