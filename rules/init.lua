local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
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
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui", "veromix", "xtightvncviewer", "conky",
                "netease-cloud-music"
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
        rule_any = {class = {"netease-cloud-music"}},
        properties = {titlebars_enabled = true}
    }, {rule = {}, properties = {placement = awful.placement.centered}},

    {rule = {class = 'Alacritty'}, properties = {width = 960, height = 640}}, {
        rule = {class = 'uTools'},
        properties = {
            placement = (awful.placement.center + awful.placement.top),
            ontop = true,
            border_width = 0
        }
    }, {rule = {class = 'plank'}, properties = {border_enable = false}}, {
        rule = {class = 'PPet'},
        properties = {
            border_width = 0,
            focusable = false,
            screen = screen[1],
            -- above = true,
            skip_taskbar = true,
            sticky = true,
            -- ontop = true,
            titlebars_enabled = false,
            --           placement = awful.placement.bottom_right
            placement = awful.placement.center_horizontal
        }
    }, {
        rule = {class = 'qqmusic'},
        properties = {
            floating = true,
            placement = awful.placement.centered,
            width = 640,
            height = 48,
            titlebars_enabled = false
        }
    }, {
        rule = {class = 'netease-cloud-music'},
        properties = {
            floating = true,
            placement = awful.placement.centered,
            width = 640,
            height = 48,
            titlebars_enabled = false
            -- shape_bounding = shape.squircle(cr, 70, 70, 8)
        }
    }
}
-- }}}
