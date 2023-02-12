return function(mod_key)
    -- Tage names
    -- Use this for reference : https://fontawesome.com/cheatsheet
    local awful = require("awful")
    local gears = require("gears") --Utilities such as color parsing and objects.

    -- awful.util.tagnames = {  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
    awful.util.tagnames = { " ", " ", " ", " ", " ", " ", " ", " ", " " };
    -- awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "➓" }
    --awful.util.tagnames = { " DEV ", " WWW ", " SYS ", " DOC ", " VBOX ", " CHAT ", " MUS ", " VID ", " GFX " }
    --awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
    --awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
    --awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }

    local table_utils = awful.util.table or gears.table -- 4.{0,1} compatibility

    awful.util.taglist_buttons = table_utils.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ mod_key }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ mod_key }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
end
