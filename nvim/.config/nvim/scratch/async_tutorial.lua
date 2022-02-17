local a = require"xx.async"
local co = coroutine
local uv = vim.loop

local timeout = function(ms, callback)
  local timer = uv.new_timer()
  uv.timer_start(timer, ms, 0, function()
    uv.timer_stop()
    uv.close(timer)
    callback()
  end)
end

local echo_2 = function(msg1, msg2, callback)
  timeout(200, function()
    callback(msg1, msg2)
  end)
end

local e2 = a.wrap(echo_2)

local async_task1 = a.sync(function()
  local x, y = a.wait(e2(1, 2))
  print(x, y)
  return x + y
end)

a.wait(async_task1())
