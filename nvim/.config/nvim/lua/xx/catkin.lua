local Job = require('plenary.job')

M = {}

function M.detect_ws_root()
  local file_dir = vim.fn.expand('%:p:h')
  if not vim.b.catkin_workspace and vim.fn.executable('catkin') > 0 and vim.fn.isdirectory(file_dir) > 0 then
    Job:new({
      command = 'catkin',
      args = { 'locate' },
      cwd = file_dir,
      on_stdout = function(err, result)
        if not err then
          vim.b.catkin_workspace = result
        end
      end,
    }):start() -- async executing
  end
end

function M.detect_package(post_hook)
  if not vim.b.catkin_package_name then
    if vim.b.ros_package_name then
      vim.schedule(post_hook)
      vim.b.catkin_package_name = vim.b.ros_package_name
      return
    else
      local file_dir = vim.fn.expand('%:p:h')
      if vim.fn.executable('catkin') > 0 and vim.fn.isdirectory(file_dir) > 0 then
        Job:new({
          command = 'catkin',
          args = { 'list', '-u', '--this' },
          cwd = file_dir,
          on_stdout = function(err, result)
            if not err then
              vim.b.catkin_package_name = result
            end
          end,
          on_exit = function(_, code)
            if code == 0 and vim.b.catkin_package_name and #vim.b.catkin_package_name > 0 then
              vim.schedule(post_hook)
            end
          end
        }):start()
      end
    end
  end
end

return M
