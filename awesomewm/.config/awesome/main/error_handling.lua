local awful         =   require("awful") --Everything related to window managment.
-- Notfication library.
local naughty       =   require("naughty")
naughty.config.defaults['icon_size'] = 100

-- Check if awesome encountered an error during startup and fell back to
-- another config.
if awful.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title  = "Oops, there were errors during startup!",
                     text   = awesome.startup_errors })
end

-- Handle runtime errors after startup.
do
local inError = false
awesome.connect_signal("debug::error", function (error)
    -- To avoid endless error loop.
    if inError then return end
    inError = true

    naughty.notify({ preset = naughty.config.presets.critical,
                     title  = "Oops, an error happened!",
                     text   = tostring(error) })
    inError = false
end)
end
