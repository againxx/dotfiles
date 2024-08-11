local keymap = vim.keymap
keymap.set("ia", "slef", "self")
keymap.set("ia", "thsi", "this")
keymap.set("ia", "previos", "previous")
keymap.set("ia", "pritn", "print")
keymap.set("ia", "flase", "false")
keymap.set("ia", "Flase", "False")
keymap.set("ia", "ture", "true")
keymap.set("ia", "Ture", "True")
keymap.set("ia", "asycn", "async")
keymap.set("ia", "raod", "road")
-- superman
keymap.set("ca", "man", function()
  if vim.fn.getcmdpos() == 4 and vim.fn.getcmdtype() == ":" then
    return "Man"
  else
    return "man"
  end
end, { expr = true })

-- obsidian.nvim
keymap.set("ca", "obsn", "ObsidianNew")
keymap.set("ca", "obso", "ObsidianOpen")
