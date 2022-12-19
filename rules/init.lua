local awful = require("awful")
local beautiful = require("beautiful")


local keys = require('bindings')

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
local rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            -- border_width = beautiful.border_width,
            border_width = 0,
            -- border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = false,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            -- placement = awful.placement.centered + awful.placement.no_overlap
            -- placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "conky",
                "netease-cloud-music",
                "Variety"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }, -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    }, -- Add titlebars to normal clients and dialogs
    {
        rule_any = {class = {"Pulseeffects"}},
        properties = {
            floating = true,
            border_width = 0,
            screen = screen[1],
            titlebars_enabled = false
        }
    },
    {
        rule_any = {class = {"Cairo-clock" , "Plank"}},
        properties = {
            floating = true,
            border_width = 0,
            screen = screen[1],
            skip_taskbar = true,
            sticky = true,
            focusable = true,
            placement = awful.placement.top,
            titlebars_enabled = false
        }
    },
    {
        rule_any = {class = {"netease-cloud-music"}},
        properties = {
            floating = true,
            border_width = 0,
            titlebars_enabled = true
        }
    },
    {rule = {}, properties = {titlebars_enabled = false}},
    {rule = {class = "Alacritty"}, properties = {width = 960, height = 640}},
    {
        rule = {class = "uTools"},
        properties = {
            placement = (awful.placement.center + awful.placement.top),
            ontop = true,
            border_width = 0
        }
    },
    {
        rule = {class = "PPet"},
        properties = {
            border_width = 0,
            focusable = false,
            screen = screen[1],
            -- above = true,
            skip_taskbar = true,
            sticky = true,
            -- ontop = true,
            titlebars_enabled = false,
            placement = awful.placement.bottom_right
        }
    },
    {rule = {class = "Plank"}, properties = {border_width = 0, sticky = true}},
    {
        rule = {class = "conky"},
        properties = {
            floating = true,
            border_width = 0,
            placement = awful.placement.top_left,
            titlebars_enabled = false,
            focusable = false,
            skip_taskbar = true,
            sticky = true
        }
    },
    {
        rule = {class = "Wine"},
        properties = {
            border_width = 0,
            floating = true,
            titlebars_enabled = false
        }
    },
    {
        rule = {class = "flameshot"},
        properties = {
            border_width = 0,
            floating = true,
            titlebars_enabled = false
        }
    },
    {
        rule = {class = "qqmusic"},
        properties = {
            floating = true,
            placement = awful.placement.centered,
            width = 640,
            height = 48,
            titlebars_enabled = false
        }
    },
    {
        rule = {class = "TeamViewer"},
        properties = {
            floating = true,
            placement = awful.placement.centered
            --       titlebars_enabled = false
        }
    },
    {
        rule = {class = "Gnome-boxes"},
        properties = {
            --       floating = true,
            placement = awful.placement.centered,
            titlebars_enabled = false
        }
    },
    {
        rule = {class = "Opera"},
        properties = {
            --       floating = true,
            placement = awful.placement.centered,
            titlebars_enabled = false
        }
    },
    {
        rule = {class = "netease-cloud-music"},
        properties = {
            floating = true,
            placement = awful.placement.centered,
            width = 640,
            height = 48,
            titlebars_enabled = false
        }
    }
}

return rules
-- }}}
