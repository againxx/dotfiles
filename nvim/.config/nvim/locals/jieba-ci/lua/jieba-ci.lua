local jobid = 0

local bin_path = vim.env.HOME .. "/.config/nvim/locals/jieba.nvim/target/release/jieba_ci"

local init_rpc = function()
  if jobid == 0 then
    return vim.fn.jobstart({ bin_path }, { rpc = true })
  else
    return jobid
  end
end

local set_keymaps = function()
  vim.keymap.set("n", "w", function()
    vim.rpcnotify(jobid, "forward")
  end)
  vim.keymap.set("n", "b", function()
    vim.rpcnotify(jobid, "backward")
  end)
end

local init = function()
  local channel_id = init_rpc()
  if channel_id == 0 then
    vim.notify("Jieba-ci: cannot start rpc process", vim.log.levels.ERROR)
  elseif channel_id == -1 then
    vim.notify("Jieba-ci: rpc process is not executable", vim.log.levels.ERROR)
  else
    jobid = channel_id
    set_keymaps()
  end
end

return { init = init }
