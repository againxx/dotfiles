local dap = require "dap"
local loop = require "dapui.render.loop"
local config = require "dapui.config"
local uitl = require "dapui.util"

---@class Subprocesses
---@field threads Threads
local Subprocesses = {}
local subprocs

local render_threads = function(self, canvas, indent)
  indent = indent or 0
  local threads = self.state:threads()
  local stopped = self.state:stopped_thread() or {}

  local function render_thread(thread, match_group)
    local first_line = canvas:length()

    canvas:write(string.rep(" ", indent))
    canvas:write(thread.name, { group = match_group })
    canvas:write ":\n"
    local frames = self.state:frames(thread.id)
    if not self._subtle_threads[thread.id] then
      frames = vim.tbl_filter(function(frame)
        return frame.presentationHint ~= "subtle"
      end, frames)
    end

    self.frames:render(canvas, frames, indent + config.windows().indent)
    local last_line = canvas:length()

    for line = first_line, last_line, 1 do
      canvas:add_mapping("toggle", function()
        self._subtle_threads[thread.id] = not self._subtle_threads[thread.id]
        loop.run()
      end, {
        line = line,
      })
    end

    canvas:write "\n\n"
  end

  if stopped.id then
    render_thread(stopped, "DapUIStoppedThread")
  end
  for _, thread in pairs(threads) do
    if thread.id ~= stopped.id then
      render_thread(thread, "DapUIThread")
    end
  end
  canvas:remove_line()
  canvas:remove_line()
end

dap.listeners.after.event_initialized["dapui-python"] = function(session)
  table.insert(subprocs.sessions, session)
end

-- dap.listeners.after.event_stopped["exception_test"] = function(session, stopped)
--   P(stopped)
--   dap.set_session(session)
--   -- session:event_stopped(stopped)
-- end
--
--
function Subprocesses:new(state)
  local elem = { threads = {}, current_state = state, states = {}, sessions = {}, expanded = {} }
  state:on_refresh(function(session)
    elem:set_state(session)
  end)
  state:on_clear(function()
    elem:clear()
  end)
  setmetatable(elem, self)
  self.__index = self
  return elem
end

function Subprocesses:clear()
  self.threads = {}
  self.current_state = nil
  self.states = {}
  self.sessions = {}
  self.expanded = {}
end

function Subprocesses:set_state(session)
  if not self.states[session] then
    local state = require "dapui.state"()
    local threads = require "dapui.components.threads"(state)
    threads.render = render_threads
    self.states[session] = state
    self.threads[session] = threads
    self.expanded[session] = true
  end
  self.threads[session].state = self.current_state
end

local set_state_fields = function(dst, src)
  dst._variables = src._variables
  dst._monitored_vars = src._monitored_vars
  dst._scopes = src._scopes
  dst._frames = src._frames
  dst._threads = src._threads
  dst._current_frame = src._current_frame
  dst._watches = src._watches
  dst._stopped_thread_id = src._stopped_thread_id
  dst._step_number = src._step_number
  dst._disabled_breakpoints = src._disabled_breakpoints
end

local switch_frame = function(session, state)
  local current_frame = state:current_frame()
  if current_frame and not vim.tbl_isempty(current_frame) then
    uitl.jump_to_frame(state:current_frame(), session, true)
  else
    local timer = vim.loop.new_timer()
    timer:start(100, 100, function()
      local threads = state:threads()
      if threads and not vim.tbl_isempty(threads) then
        local _, thread = next(threads)
        local frames = state:frames(thread.id)
        if frames and not vim.tbl_isempty(frames) then
          for _, frame in ipairs(frames) do
            if frame.presentationHint ~= "subtle" then
              vim.schedule(function()
                uitl.jump_to_frame(frame, session, true)
              end)
              break
            end
          end
          timer:stop()
          timer:close()
        end
      end
    end)
  end
end

function Subprocesses:render_one_session(session, canvas)
  local thread = self.threads[session]
  local expanded = self.expanded[session]
  local suffix
  if session.current_frame then
    suffix = "Stopped at line " .. session.current_frame.line
  elseif session.stopped_thread_id then
    suffix = "Stopped"
  else
    suffix = "Running"
  end
  local config_name = (session.config or {}).name or "No name"
  local icons = config.icons()
  local prefix = thread and expanded and icons.expanded or icons.collapsed
  prefix = prefix .. " "
  local indicator = session == dap.session() and " " or ""
  canvas:write(string.format("%s %s (%s): %s", prefix, config_name, suffix, indicator), { group = "DapUIProcess" })
  canvas:add_mapping(config.actions.EXPAND, function()
    local current_session = dap.session()
    if current_session == session then
      self.expanded[session] = not self.expanded[session]
    else
      set_state_fields(self.states[current_session], self.current_state)
      self.threads[current_session].state = self.states[current_session]
      if not self.states[session] then
        self:set_state(session)
      end
      set_state_fields(self.current_state, self.states[session])
      self.threads[session].state = self.current_state
      dap.set_session(session)
      session:update_threads()
      switch_frame(session, self.current_state)
    end
    loop.run()
  end)
  canvas:write "\n"
  if thread and not vim.tbl_isempty(thread.state:threads()) and expanded then
    thread:render(canvas, 2)
    canvas:write "\n"
  end
end

function Subprocesses:render(canvas)
  for _, session in ipairs(self.sessions) do
    self:render_one_session(session, canvas)
  end
end

return {
  name = "DAP Subprocesses",
  buf_options = { filetype = "dapui_subprocesses" },
  setup = function(state)
    subprocs = Subprocesses:new(state)
  end,
  render = function(canvas)
    subprocs:render(canvas)
  end,
}
