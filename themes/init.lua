-- Standard awesome library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/gtk/theme.lua")
