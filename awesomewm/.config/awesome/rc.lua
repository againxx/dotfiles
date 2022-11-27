--[[
        EndeavourOS Awesome WM configuration template.
        More info       :   https://github.com/awesomeWM

        Created by      :   S4NDM4N

        Personal repo   :   https://github.com/s4ndm4n82/eos-awesome-ce

        Offical repo    :   https://github.com/EndeavourOS-Community-Editions/awesome

        Used tecnologies
        ~~~~~~~~~~~~~~~~
        freedesktop     :   https://github.com/lcpz/awesome-freedesktop

        Copycats themes :   https://github.com/lcpz/awesome-copycats

        Lain            :   https://github.com/lcpz/lain

--]]

-- {{{ Required library.
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library.
local gears         =   require("gears") --Utilities such as color parsing and objects.
local awful         =   require("awful") --Everything related to window managment.
                        require("awful.autofocus")

-- Widget and layout library.
local wibox         =   require("wibox")

-- Theme handling library.
local beautiful     =   require("beautiful")

-- Notfication library.
local naughty       =   require("naughty")
naughty.config.defaults['icon_size'] = 100

-- Menubar
local menubar = require("menubar")

-- Other libraries
local lain          =   require("lain")
local freedesktop   =   require("freedesktop")

-- Enabling hotkey help widget for VIM and other apps
-- when client with a matching name is openend:
local hotkeys_popup =   require("awful.hotkeys_popup").widget
                        require("awful.hotkeys_popup.keys")
local myTable       =   awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}}

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user_variables")
local mod_key = RC.vars.mod_key
local alt_key = RC.vars.alt_key
local ctrl_key = RC.vars.ctrl_key

-- Error handling
require("main.error_handling")

-- {{{ To autostart windowsless processes.
local function run_once(cmd_list)
    for _, cmd in ipairs(cmd_list) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "unclutter" }) -- Entries must be comma-separated.
-- }}}


local themes = {
    --[[
    Add the folder name as shown below one after the other as a new line.
    The position of the name is the number you need to add as the number of your
    chosen theme.
        "powerarrow-blue", -- 1
        "powerarrow",      -- 2
        "multicolor",      -- 3
    --]]
    "eos-default", --1
}

-- {{{ Choosing your theme.
local themeChosen = themes[1] -- Number is from the above list. Replace with your selected number.
local pathOfTheme = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), themeChosen)
beautiful.init(pathOfTheme)
-- }}}

-- {{{ awesome variables
awful.util.terminal = RC.vars.terminal

-- Tage names
-- Use this for reference : https://fontawesome.com/cheatsheet

-- awful.util.tagnames = {  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
awful.util.tagnames = { " ", " ", " ", " ", " ", " ", " ", " ", " " };
-- awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "➓" }
--awful.util.tagnames = { " DEV ", " WWW ", " SYS ", " DOC ", " VBOX ", " CHAT ", " MUS ", " VID ", " GFX " }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
-- }}}

-- {{{ Layouts
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --awful.layout.suit.floating,
}

awful.util.taglist_buttons = myTable.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ mod_key }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ mod_key }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = myTable.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", themeChosen))
beautiful.useless_gap = 4
-- }}}

-- {{{ Menu
local awesomeMainMenu = {
    { "Hotkeys", function() return false, hotkeys_popup.show_help end },
    { "Manual", RC.vars.terminal .. " -e 'vman awesome'" },
    { "Edit Config", RC.vars.config_editor },
    { "Arandr", "arandr" },
    { "Restart", awesome.restart },
}

-- Buiulding the right click menu.
awful.util.rcMainMenu = freedesktop.menu.build({
    before = {
        { "Awesome", awesomeMainMenu },
        --{ "Awesome", awesomeMainMenu, beautiful.awesome_icon }
        --{ "Atom", "atom" },
        -- Other traids can be put here.

    },
    after = {
        { "Terminal", RC.vars.terminal },
        { "Log out", function() awesome.quit() end},
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- Other triads can be put here.
    }
})

-- Menubar configuration.
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for application that needs it.
-- }}}

-- {{{ Wallpaper
-- Re-sets the wallpaper when a screen's geometry changes (e.g. Different resolution).
screen.connect_signal("property::geometry", function(s)
    --Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen.
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- }}}

-- Create a wibox for each screen and add it.
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- {{{ Mosue bindings.
root.buttons(myTable.join(
    awful.button({ }, 3, function () awful.util.rcMainMenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalKeys = myTable.join(
    -- {{{ Personal keybindings.
    --[[ dmenu
    awful.key({ modkey, "Shift" }, "d",
    function ()
        awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
	end,
        {description = "Show dmenu.", group = "Hotkeys"}),
    -- ]]
    -- Awesome menubar
    awful.key({ mod_key }, "d", function() menubar.show() end,
        {description = "Show awesome menubar.", group = "Hotkeys"}),
    awful.key({ mod_key, ctrl_key }, "w", function() awful.util.rcMainMenu:show() end,
        {description = "Show the main menu.", group = "Hotkeys"}),

    -- Awesome
    awful.key({ mod_key }, "F1", hotkeys_popup.show_help,
        {description = "Launches this help.", group = "Awesome"}),
    awful.key({ mod_key }, "s", hotkeys_popup.show_help,
        {description = "Launches this help.", group = "Awesome"}),
    awful.key({ mod_key }, "r", awesome.restart,
        {description = "Reloads awesome.", group = "Awesome"}),
    awful.key({ mod_key, "Shift" }, "q", function() awful.spawn.with_shell( "killall awesome" ) end,
        {description = "Quit awesome.", group = "Awesome"}),

    -- Prompt menu
    awful.key({ mod_key }, "/", function() awful.util.spawn(RC.vars.app_searcher) end,
        {description = "Run applications.", group = "Hotkeys"}),

    -- Show/Hide top wibox
    awful.key({ mod_key, "Shift" }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
    {description = "Toggle top wibox.", group = "Awesome"}),

    -- Super + ... function (F'x') keys.
    awful.key({ mod_key }, "F2", function() awful.util.spawn( RC.vars.gui_editor ) end,
        {description = "Launch the text editor." , group = "Function keys" }),
    awful.key({ mod_key }, "F3", function() awful.util.spawn( RC.vars.file_manager ) end,
        {description = "Launch the filemanager", group = "Function keys" }),
    awful.key({ mod_key }, "F4", function() awful.util.spawn( "xfc-terminal --drop-down" ) end,
        {description = "Dropdown terminal.", group = "Function keys"}),

    -- Super + ...
    awful.key({ mod_key }, "Return", function () awful.util.spawn( RC.vars.terminal ) end,
        {description = "Launch the terminal.", group="Hotkeys"}),
    awful.key({ mod_key, "Shift" }, "Return", function () awful.util.spawn( RC.vars.file_manager ) end,
        {description = "Launches the filemanager.", group = "Hotkeys" }),
    awful.key({ mod_key }, "w", function () awful.util.spawn( RC.vars.browser ) end,
        {description = "Launch default browser.", group = "Hotkeys" }),
    awful.key({ mod_key }, "e", function () awful.util.spawn( RC.vars.gui_editor ) end,
        {description = "Launch graphical text editor.", group = "Hotkeys" }),
    awful.key({ mod_key }, "t", function () awful.util.spawn( RC.vars.editor ) end,
        {description = "Launch default terminal editor.", group = "Hotkeys" }),
    awful.key({ mod_key }, "Escape", function () awful.util.spawn( RC.vars.screen_locker ) end,
        {description = "Locks the screen on demand.", group = "Hotkeys" }),
    awful.key({ mod_key }, "c", function () awful.util.spawn( "code" ) end,
        {description = "Launches Visual Studio Code.", group = "Hotkeys" }),

    -- Copy primary to clipboard (terminals to gtk)    
    awful.key({ mod_key, ctrl_key }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "Copy terminal to gtk.", group = "Hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ mod_key, ctrl_key }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
        {description = "Copy gtk to terminal.", group = "Hotkeys"}),

    -- Super + ... eos apps.
    awful.key({ mod_key, "Shift" }, "w", function () awful.util.spawn( "eos-welcome --enable" ) end,
        {description = "EndeavourOS welcome app.", group = "EOS Apps" }),
    -- awful.key({ ctrl_key, alt_key }, "l", function () awful.util.spawn( "eos-log-tool" ) end,
    --     {description = "EndeavourOS log tool.", group = "EOS Apps" }),
    awful.key({ mod_key, "Shift" }, "i", function () awful.util.spawn( "eos-apps-info" ) end,
        {description = "EndeavourOS log tool.", group = "EOS Apps" }),
    awful.key({ mod_key, "Shift" }, "r", function () awful.util.spawn( "reflector-simple" ) end,
        {description = "EndeavourOS reflector simple.", group = "EOS Apps" }),
    awful.key({ mod_key, "Shift" }, "m", function () awful.util.spawn( RC.vars.terminal .. "-e eos-rankmirrors" ) end,
        {description = "EndeavourOS rank mirrors.", group = "EOS Apps" }),

    -- Screenshots
    awful.key({ }, "Print", function () awful.util.spawn( "xfce4-screenshooter -i" ) end,
        {description = "Use xfce screenshooter.", group = "Screenshots" }),

    -- Layout switching
    awful.key({ alt_key, "Shift" }, "l", function () awful.tag.incmwfact( 0.05) end,
        {description = "Increase master width factor.", group = "Layout"}),
    awful.key({ alt_key, "Shift" }, "h", function () awful.tag.incmwfact(-0.05) end,
        {description = "Decrease master width factor.", group = "Layout"}),
    awful.key({ mod_key, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "Increase the number of master clients.", group = "Layout"}),
    awful.key({ mod_key, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "Decrease the number of master clients.", group = "Layout"}),
    awful.key({ mod_key, ctrl_key }, "[", function () awful.tag.incncol( 1, nil, true) end,
        {description = "Increase the number of columns.", group = "Layout"}),
    awful.key({ mod_key, ctrl_key }, "]", function () awful.tag.incncol(-1, nil, true) end,
        {description = "Decrease the number of columns.", group = "Layout"}),
    awful.key({ mod_key }, "]", function () awful.layout.inc( 1) end,
        {description = "select next", group = "Layout"}),
    --awful.key({ modkey, "Shift"}, "space", function () awful.layout.inc(-1) end,
        -- {description = "select previous", group = "Layout"}),

    -- Tag browsing with modkey
    awful.key({ mod_key }, ",",   awful.tag.viewprev,
        {description = "View previous.", group = "Tag"}),
    awful.key({ mod_key }, ".",  awful.tag.viewnext,
        {description = "View next.", group = "Tag"}),
    awful.key({ alt_key }, "Escape", awful.tag.history.restore,
        {description = "Go back.", group = "Tag"}),

    -- Default client focus
    awful.key({ mod_key }, "]", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index.", group = "Client"}),
    awful.key({ mod_key }, "[", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index.", group = "Client"}),

    -- By direction client focus
    awful.key({ mod_key }, "j",
        function()
            pcall(awful.client.focus.global_bydirection, "down")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus down.", group = "Client"}),
    awful.key({ mod_key }, "k",
        function()
            pcall(awful.Client.focus.global_bydirection, "up")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus up.", group = "Client"}),
    awful.key({ mod_key }, "h",
        function()
            pcall(awful.client.focus.global_bydirection, "left")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus left.", group = "Client"}),
    awful.key({ mod_key }, "l",
        function()
            pcall(awful.client.focus.global_bydirection, "right")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus right.", group = "Client"}),

    -- By direction client focus with arrows
    awful.key({ ctrl_key, mod_key }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus down.", group = "Client"}),
    awful.key({ ctrl_key, mod_key }, "Up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus up.", group = "Client"}),
    awful.key({ ctrl_key, mod_key }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus left.", group = "Client"}),
    awful.key({ ctrl_key, mod_key }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus right.", group = "Client"}),

    -- Layout manipulation
    awful.key({ mod_key, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "Swap with next client by index.", group = "Client"}),
    awful.key({ mod_key, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "Swap with previous client by index.", group = "Client"}),
    awful.key({ mod_key, ctrl_key }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "Focus the next screen.", group = "Screen"}),
    awful.key({ mod_key, ctrl_key }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "Focus the previous screen.", group = "Screen"}),
    awful.key({ mod_key }, "u", awful.client.urgent.jumpto,
        {description = "Jump to urgent client", group = "Client"}),
    awful.key({ alt_key }, "Tab",
        function ()
          local previous_client = awful.client.focus.history.list[2]
          client.focus = previous_client
          local client_tag = client.focus and client.focus.first_tag or nil
          if client_tag then
            client_tag:view_only()
          end
          previous_client:raise()
        end,
        {description = "Go back.", group = "Client"}),

    -- On the fly useless gaps change
    awful.key({ mod_key, "Shift" }, "=", function () lain.util.useless_gaps_resize(1) end,
              {description = "Increment useless gaps.", group = "Tag"}),
    awful.key({ mod_key, "Shift" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "Decrement useless gaps.", group = "Tag"}),

    -- Dynamic tagging
    awful.key({ mod_key, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "Add new tag.", group = "Tag"}),
    awful.key({ mod_key, ctrl_key }, "r", function () lain.util.rename_Tag() end,
              {description = "Rename tag.", group = "Tag"}),
    awful.key({ mod_key, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "Move tag to the left.", group = "Tag"}),
    awful.key({ mod_key, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "Move tag to the right", group = "Tag"}),
    awful.key({ mod_key, "Shift" }, "y", function () lain.util.delete_tag() end,
              {description = "Delete tag", group = "Tag"}),

    -- Retore window
    awful.key({ mod_key, ctrl_key }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "Restore minimized.", group = "Client"}),

    -- ALSA volume control
    awful.key({ mod_key, "Shift"}, "Up",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update() end,
            {description = "Volumn up.", group = "Audio"}),
    awful.key({ mod_key, "Shift" }, "Down",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update() end,
            {description = "Volumn down.", group = "Audio"}),
    awful.key({ mod_key, alt_key }, "m",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update() end,
            {description = "Volumn mute.", group = "Audio"}),
    awful.key({ mod_key, "Shift" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update() end,
            {description = "Volumn full.", group = "Audio"}),
    awful.key({ mod_key, "Shift" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update() end,
            {description = "Volumn 0.", group = "Audio"})

    -- }}}
)

local clientKeys = myTable.join(
    awful.key({ alt_key, "Shift" }, "m", lain.util.magnify_client,
              {description = "Magnify client", group = "Client"}),
    awful.key({ mod_key }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ mod_key }, "q", function (c) c:kill() end,
              {description = "Close", group = "Hotkeys"}),
    awful.key({ mod_key, "Shift" }, "space",  awful.client.floating.toggle,
              {description = "Toggle floating", group = "Client"}),
    awful.key({ mod_key, ctrl_key }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "Client"}),
    awful.key({ mod_key }, "o", function (c) c:move_to_screen() end,
              {description = "Move to screen", group = "Client"}),
    awful.key({ mod_key }, "t", function (c) c.ontop = not c.ontop end,
              {description = "Toggle keep on top", group = "Client"}),
    awful.key({ mod_key }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "Minimize", group = "Client"}),
    awful.key({ mod_key }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "Maximize", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "View tag #", group = "Tag"}
        descr_toggle = {description = "Toggle tag #", group = "Tag"}
        descr_move = {description = "Move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
    end
    globalKeys = myTable.join(globalKeys,
        -- View tag only.
        awful.key({ mod_key }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ mod_key, ctrl_key }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ mod_key, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ mod_key, ctrl_key, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

local clientButtons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ mod_key }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ mod_key }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- }}}

-- {{{ Set keys
root.keys(globalKeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will matched to these rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientKeys,
                     buttons = clientButtons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebar
    { rule_any = { type = { "dialog", "normal" } },
        properties = { titlebars_enabled = false } },

    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command
    --{ rule = { class = browser },
      --properties = { screen = 1, tag = awful.util.tagnames[1] } },

    -- Set applications to always map on the tag 2 on screen 1 with tag switching.
    -- find class or role via xprop command
    --{ rule = { class = terminal },
      --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    -- Set applications to always map on the tag 3 on screen 2 with tag switching.
    -- find class or role via xprop command
    --{ rule = { class = terminal },
      --properties = { screen = 2, tag = awful.util.tagnames[3], switchtotag = true  } },

    -- Set applications to be maximized at startup.
    -- find class or role via xprop command
    { rule = { class = guiEditor },
        properties = { maximized = true } },

    -- Set applications to be maximized at startup with floating disabled.
    -- find class or role via xprop command        
    { rule = { class = filemanager },
        properties = { maximized = true, floating = false } },
    { rule = { class = "code" },
        properties = { maximized = false, floating = false } },
    { rule = { class = "Arandr" },
        properties = { maximized = false, floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "yad", -- For yad windows.
        },
        class = {
          "Galculator",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Yad"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.          
        }
      }, properties = { floating = true }},

          -- Floating clients but centered in screen
          { rule_any = {
            class = {
                "Polkit-gnome-authentication-agent-1",
                "Arcolinux-calamares-tool.py"
                     },
                    },
           properties = { floating = true },
               callback = function (c)
                    awful.placement.centered(c,nil)
                end }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

--[[ Titlebar
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
--]]

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

-- {{{ Autostart applications
local auto_run_apps = {
    -- List all the apps you need to run on WM startup.
    "nm-applet",
    "numlockx on",
    "dex --autostart --environment awesome",
    "sleep 1 && picom -b --config  $HOME/.config/picom/picom.conf",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "fcitx5 -rb",
}

if RC.vars.auto_run then
    -- For loop runs through the above array and add each app to the command.
    for app = 1, #auto_run_apps do
        awful.spawn.with_shell(auto_run_apps[app])
    end
end
-- }}}
