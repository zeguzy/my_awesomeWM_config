-- 布局和freedesktop右键菜单
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local menubar = require("menubar")
--local freedesktop = require("freedesktop")
require('layout/layouts')

-- {{{ Menu
-- Create a launcher widget and a main menu
require('layout/menu')
--mylauncher = awful.widget.launcher({
--    image = beautiful.awesome_icon,
--    menu = mymainmenu
--})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

