
 require("revelation")

--vicious = require("vicious")
--widgets precious
require("precious.battery")
require("precious.cpu")
require("precious.ram")
require("precious.calendar")


-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
 
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(awful.util.getdir("config") .. "/themes/lined/theme.lua")
-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}



 
dofile(awful.util.getdir("config") .. "/" .. "tags.lua")
dofile(awful.util.getdir("config") .. "/" .. "menu.lua")

dofile(awful.util.getdir("config") .. "/" .. "wibox.lua")

dofile(awful.util.getdir("config") .. "/" .. "mousebindings.lua")

dofile(awful.util.getdir("config") .. "/" .. "keybindings.lua")

dofile(awful.util.getdir("config") .. "/" .. "signals.lua")


-- Autorun programs
autorun = true
autorunApps =
{
   "xscreensaver -no-splash",
   "xbindkeys",
   --"firefox",
   "nm-applet",
   "wmname LG3D",
   "xcompmgr",

 }
if autorun then
   for app = 1, #autorunApps do
awful.util.spawn_with_shell("/home/matthias/.config/awesome/run_once.sh " .. autorunApps[app]) 
-- awful.util.spawn_with_shell(awful.util.getdir("config") .. "run_once.sh" .. autorunApps[app])

   end
end


--load files

dofile(awful.util.getdir("config") .. "/" .. "rules.lua")


