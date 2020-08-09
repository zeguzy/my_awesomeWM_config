--  rc.lua
--  custom initialisation for awesome windowmanager 4.0.x
--
 -- Copyright (C) 2012, 2013 by Togan Muftuoglu <toganm@opensuse.org>
 -- Copyright (C) 2015, 2016 by Sorokin Alexei <sor.alexei@meowr.ru>
 -- This program is free software; you can redistribute it and/or
 -- modify it under the terms of the GNU General Public License as
 -- published by the Free Software Foundation; either version 2, or (at
 -- your option) any later version.

 -- This program is distributed in the hope that it will be useful, but
 -- WITHOUT ANY WARRANTY; without even the implied warranty of
 -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 -- General Public License for more details.

 -- You should have received a copy of the GNU General Public License
 -- along with GNU Emacs; see the file COPYING.  If not, write to the
 -- Free Software Foundation, Inc.,  51 Franklin Street, Fifth Floor,
 -- Boston, MA 02110-1301 USA


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Introspection
local lgi = require("lgi")
local gtk = lgi.require("Gtk", "3.0")
-- Freedesktop integration
local freedesktop = require("freedesktop")
-- calendar functions
local calendar2 = require("calendar2")
-- Extra widgets
local vicious = require("vicious")

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
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- Use personal theme if existing else goto default.
do
    local user_theme, ut
    user_theme = awful.util.getdir("config") .. "/themes/openSUSE/theme.lua"
    ut = io.open(user_theme)
    if ut then
        io.close(ut)
        beautiful.init(user_theme)
    else
        print("Personal theme doesn't exist, falling back to openSUSE")
        beautiful.init(awful.util.get_themes_dir() .. "openSUSE/theme.lua")
    end
end

-- autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end


-- autostart programs
--run_once({ "utools &" })
run_once({ "nm-applet -sm-disable" })
--run_once({ "mate-power-manager" })
run_once({ "compton" })
run_once({ "/home/zegu/.config/xrandr/mySet.sh &" })
--run_once({ "blueman-applet  &" })
--run_once({ "volumeicon &" })
run_once({ "pulseaudio &" })
--run_once({ "pa-applet &" })


--个人快捷键设置
--filemanager = "caja"
filemanager = "thunar"
--filemanager = "pcmanfm"
browser     = "chromium"
music 		= "netease-cloud-music"
idea        = "/opt/intellij-idea-ultimate-edition/bin/idea.sh"
vscode      = "code"
volume      = "pavucontrol"
virtualbox  = "virtualbox"
laucher     = "rofi -show run"
scrcpy      = "~/.config/awesome/script/scrcpy.sh"
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or os.getenv("VISUAL") or "vi"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal
theme.icon_theme = "Hey-classic-dark"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.magnifier,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local function lookup_icon(icon, size)
    local icon_theme = gtk.IconTheme.get_default()
    local icon_info = icon_theme:lookup_icon(icon, size, "USE_BUILTIN")
    return icon_info and icon_info:get_filename() or nil
end

mysystemmenu = {
   { "Lock Screen",     "light-locker-command --lock",  lookup_icon("system-lock-screen", 16) },
   { "Logout",           function() awesome.quit() end, lookup_icon("system-log-out", 16)     },
   { "Reboot System",   "systemctl reboot",             lookup_icon("system-restart", 16)       },
   { "Shutdown System", "systemctl poweroff",           lookup_icon("system-shutdown", 16)    }
}

myawesomemenu = {
   { "Restart Awesome", awesome.restart, lookup_icon("view-refresh", 16) },
   { "Edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "rc.lua", lookup_icon("package_settings", 16) },
   { "manual", terminal .. " -e man awesome", lookup_icon("help-browser", 16) }
}



mymainmenu = awful.menu({ items = { 
                                    { "terminal", terminal,beautiful.terminal_icon},
                                    { "firefox", browser,beautiful.firefox_icon},
									{ "file", filemanager,beautiful.file_manager_icon},
									{ "music", music,beautiful.music_icon},
									{ "idea", idea,beautiful.idea_icon},
									{ "vscode", vscode,beautiful.vscode_icon},
									{ "virtualbox", virtualbox,beautiful.win_icon},
   { "Lock Screen",     "light-locker-command --lock",  lookup_icon("system-lock-screen", 16) },
   { "Logout",           function() awesome.quit() end, lookup_icon("system-log-out", 16)     },
   { "Reboot System",   "systemctl reboot",             lookup_icon("system-restart", 16)       },
   { "Shutdown System", "systemctl poweroff",           lookup_icon("system-shutdown", 16)    }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.opensuse_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- We need spacer and separator between the widgets
spacer = wibox.widget.textbox()
separator = wibox.widget.textbox()
spacer:set_text(" ")
separator:set_text("|")

-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a   %H:%M ", 60)
calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")

mycpuwidget = wibox.widget.textbox()
vicious.register(mycpuwidget, vicious.widgets.cpu, "$1%")

mybattery = wibox.widget.textbox()
vicious.register(mybattery, function(format, warg)
    local args = vicious.widgets.bat(format, warg)
    if args[2] < 50 then
        args['{color}'] = 'red'
    else
        args['{color}'] = 'green'
    end
    return args
end, '<span foreground="${color}">bat: $2% $3h</span>', 10, 'BAT0')


-- Weather widget
myweatherwidget = wibox.widget.textbox()
weather_t = awful.tooltip({ objects = { myweatherwidget },})
vicious.register(myweatherwidget, vicious.widgets.weather,
          function (widget, args)
              weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
              return args["{tempc}"] .. "C"
          end, 1800, "EDDN")
          --'1800': check every 30 minutes.
          --'EDDN': Nuernberg ICAO code.


-- Keyboard map indicator and changer
-- default keyboard is us, second is german adapt to your needs
--

kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget.set_align = "right"
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][1] .. " ")
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget.text = " " .. t[1] .. " "
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
          awful.button({ }, 1, function(t) t:view_only() end),
          awful.button({ modkey }, 1, function(t)
                        if client.focus then
                            client.focus:move_to_tag(t)
                        end
                    end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                  if client.focus then
                                      client.focus:toggle_tag(t)
                                  end
                              end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
          awful.button({ }, 1, function (c)
                        if c == client.focus then
                            c.minimized = true
                        else
                            -- Without this, the following :isvisible()
                            -- makes no sense
                            c.minimized = false
                            if not c:isvisible() and c.first_tag then
                                c.first_tag:view_only()
                            end
                            -- This will also un-minimise the client, if needed
                            client.focus = c
                            c:raise()
                        end
                    end),
                    awful.button({ }, 3, client_menu_toggle_fn()),
                    awful.button({ }, 4, function ()
                                  awful.client.focus.byidx(1)
                              end),
                    awful.button({ }, 5, function ()
                                  awful.client.focus.byidx(-1)
                              end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
--     set_wallpaper(s)

    -- Each screen has its own tag table.
--     awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
awful.tag.add("server", {
        icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/server.png",
        layout = awful.layout.suit.tile.left,
        screen = s,
        selected= true,
})
 --awful.tag.add("Terminal", {
 --        icon = "/home/zegu/.config/awesome/themes/gtk/icons/apps/terminal.png",
 --        layout = awful.layout.suit.tile.left,
 --        screen = s,
 --        selected= true,
 --})

awful.tag.add("Code", {
        icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/vscode_icon.png",
        layout = awful.layout.suit.tile.left,
        screen = s,
})
awful.tag.add("Browser", {
        icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/chrome.png",
        layout = awful.layout.suit.tile.left,
        screen = s,
})
awful.tag.add("Scrcpy", {
        icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/android.png",
        layout = awful.layout.suit.floating,
        screen = s,
})
awful.tag.add("music", {
        icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/music_icon.png",
        layout = awful.layout.suit.floating,
        screen = s,
})
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
              awful.button({ }, 1, function () awful.layout.inc( 1) end),
              awful.button({ }, 3, function () awful.layout.inc(-1) end),
              awful.button({ }, 4, function () awful.layout.inc( 1) end),
              awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
		style    = {
           	 shape        =gears.shape.squircle,
       		 
    		},

    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
	style   = {
    --    	border_width = 1,
    --   	border_color = '#777777',
            shape        = gears.shape.squircle,
    
    	},
	layout  = {
 		spacing = 1,
            	spacing_widget = {
            		{
                		forced_width = 0,
                		widget       = wibox.widget.separator
            		},
            		valign = 'right',
            		halign = 'center',
           		widget = wibox.container.place,
        },
  
        layout  = wibox.layout.fixed.horizontal
    },
widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 0,
                    widget  = wibox.container.margin,
                },
                 {
                       id     = 'text_role',
                       widget = wibox.widget.textbox,
                      },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 4,
            right = 4,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        forced_width = 148,
        widget = wibox.container.background,
    },

    }
                                    
    local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s , height = 22, opacity = 0.8})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
--             mylauncher,
            s.mytaglist,
--             s.mypromptbox,
        },
         {
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist, -- Middle widget
--             mykeyboardlayout,
             volumearc_widget({
    			main_color = '#af13f7',
    			mute_color = '#ff0000',
    			thickness = 2,
    			height = 35,
				path_to_icon= "/home/zegu/.config/awesome/themes/openSUSE/icons/status/音量.svg"

			}),
            mytextclock,
            separator,
            spacer,
            wibox.widget.systray(),
            spacer,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    --个人快捷键
    awful.key({ modkey,           }, "b", function () awful.spawn(browser) end,
            {description = "run browser",group="launcher"}),
    awful.key({ modkey,           }, "z", function () awful.spawn(laucher) end,
            {description = "run rofi",group="launcher"}),
    awful.key({ modkey,           }, "e",function () awful.spawn(filemanager )end,
            {description = "run fileManager",group="launcher"}),
    awful.key({ modkey,           }, "v",function () awful.spawn(volume)end,
            {description = "run volume",group="launcher"}),
    awful.key({ modkey,    }, "c", function () awful.spawn(vscode) end,
              {description = "run vscode", group = "launcher"}),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "c", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    -- This function below will enable ssh login as long as the remote host is
    -- defined in $HOME/.ssh/config else by giving the remote host a name at
    -- the prompt which will also work
    awful.key({ modkey },           "s",     function ()
                  awful.prompt.run({ prompt = "ssh: " },
                  mypromptbox[mouse.screen].widget,
                  function(h) awful.util.spawn(terminal .. " -e slogin " .. h) end,
                  function(cmd, cur_pos, ncomp)
                      -- Get hosts and hostnames
                      local hosts = {}
                      f = io.popen("sed 's/#.*//;/[ \\t]*Host\\(Name\\)\\?[ \\t]\\+/!d;s///;/[*?]/d' " .. os.getenv("HOME") .. "/.ssh/config | sort")
                      for host in f:lines() do
                          table.insert(hosts, host)
                      end
                      f:close()
                      -- Abort completion under certain circumstances
                      if cur_pos ~= #cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " " then
                          return cmd, cur_pos
                      end
                      -- A match
                      local matches = {}
                      table.foreach(hosts, function(x)
                          if hosts[x]:find("^" .. cmd:sub(1, cur_pos):gsub('[-]', '[-]')) then
                              table.insert(matches, hosts[x])
                          end
                      end)
                      -- If there are no matches
                      if #matches == 0 then
                          return cmd, cur_pos
                      end
                      -- Cycle
                      while ncomp > #matches do
                          ncomp = ncomp - #matches
                      end
                      -- Return the match and position
                      return matches[ncomp], #matches[ncomp] + 1
                  end,
                  awful.util.getdir("cache") .. "ssh_history")
              end,
              {description = "ssh login", group = "awesome"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          -- To fix Flash fullscreen issues if still seeing bottom bar
          -- For chromium change "plugin-container" to "exe"
          "plugin-container",
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
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

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local top_titlebar = awful.titlebar(c, {
    size      = 0,
})
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    top_titlebar: setup {
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
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
awful.spawn.with_shell("~/.config/awesome/autorun.sh &")
