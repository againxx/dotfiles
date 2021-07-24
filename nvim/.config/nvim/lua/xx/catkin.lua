-- function! s:PackageCallback(job_id, data, event) abort dict
--     if a:event ==# 'stdout'
--         let b:catkin_package_name = a:data[0]
--     elseif a:event ==# 'exit'
--         if !empty(b:catkin_package_name)
--             call self.on_exit_func()
--             let b:catkin_initialized = 1
--         else
--             let b:catkin_initialized = -1
--         endif
--     endif
-- endfunction

-- let s:callbacks = {
-- \ 'on_stdout': function('s:PackageCallback'),
-- \ 'on_exit': function('s:PackageCallback')
-- \ }

local Job = require('plenary.job')

M = {}

function M.detect_ws_root()
  if not vim.b.catkin_workspace and vim.fn.executable('catkin') > 0 then
    Job:new({
      command = 'catkin',
      args = { 'locate' },
      on_stdout = function(err, result)
        if not err then
          vim.b.catkin_workspace = result
        end
      end,
    }):start() -- async executing
  end
end

function M.detect_package(post_hook)
  post_hook = post_hook or function() print('dumb func') end
  if not vim.b.catkin_package_name then
    if vim.b.ros_package_name then
      vim.defer_fn(post_hook, 500)
      vim.b.catkin_package_name = vim.b.ros_package_name
      return
    else
      local file_dir = vim.fn.expand('%:h')
      if vim.fn.executable('catkin') > 0 and vim.fn.isdirectory(file_dir) then
        Job:new({
          command = 'catkin',
          args = { 'list', '-u', '--this' },
          on_stdout = function(err, result)
            if not err then
              vim.b.catkin_package_name = result
            end
          end,
          on_exit = function(_, code)
            if code == 0 and vim.b.catkin_package_name and #vim.b.catkin_package_name > 0 then
              vim.defer_fn(post_hook, 500)
            end
          end
        }):start()
      end
    end
  end
end

return M
