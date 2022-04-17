-- manually set matchup's mappings
-- matchup will unmap matchit's mappings, thus this file should be in the after/

local keymap = vim.keymap
local plug_opts = { silent = true, nowait = true }

keymap.set({ "n", "x" }, "%", "<Plug>(matchup-%)", plug_opts)
keymap.set({ "n", "x" }, "g%", "<Plug>(matchup-g%)", plug_opts)
keymap.set("n", "ds%", "<Plug>(matchup-ds%)", plug_opts)
keymap.set("n", "cs%", "<Plug>(matchup-cs%)", plug_opts)
keymap.set({ "x", "o" }, "a%", "<Plug>(matchup-a%)", plug_opts)
keymap.set({ "x", "o" }, "i%", "<Plug>(matchup-i%)", plug_opts)

-- %           |<plug>(matchup-%)|                         nx     motion
-- g%          |<plug>(matchup-g%)|                        nx     motion
-- [%          |<plug>(matchup-[%)|                        nx     motion
-- ]%          |<plug>(matchup-]%)|                        nx     motion
-- z%          |<plug>(matchup-z%)|                        nx     motion
-- a%          |<plug>(matchup-a%)|                        x      text_obj
-- i%          |<plug>(matchup-i%)|                        x      text_obj
-- ds%         |<plug>(matchup-ds%)|                       n      surround
-- cs%         |<plug>(matchup-cs%)|                       n      surround
-- (none)      |<plug>(matchup-hi-surround)|               n      matchparen
