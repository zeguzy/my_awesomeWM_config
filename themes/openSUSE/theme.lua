------------------------------------------------------------
-- openSUSE awesome theme based on awesome default theme --
------------------------------------------------------------

theme = {}
-- theme.gtk = gtk.get_theme_variables()
theme.font          = "Source Code Pro 12"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#01579B"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/openSUSE/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/openSUSE/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/openSUSE/submenu.png"
theme.menu_height = 25
theme.menu_width  = 200
theme.taglist_spacing     = 2
theme.taglist_font        = "ButterHaunted 13"
theme.taglist_bg_focus	  = "#01579B"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/sticky_focus_active.png"
theme.titlebar_close_button_focus =  "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_close_button_focus_hover = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/close_focus.png"

theme.titlebar_floating_button_normal_inactive = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_focus_inactive = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/floating_focus_inactive.png"

theme.titlebar_floating_button_normal_active = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/floating_focus_active1.png"
theme.titlebar_floating_button_focus_active = "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/floating_focus_inactive1.png"

theme.titlebar_ontop_button_focus_inactive=  "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive=  "/home/zegu/.config/awesome/themes/openSUSE/icons/titlebar/ontop_focus_active.png"


theme.firefox_icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/firefox.png"
theme.chrome_icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/chrome.png"
theme.android= "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/android.png"
theme.terminal_icon = "/home/zegu/.config/awesome/themes/openSUSE/icons/apps/terminal.png"
theme.file_manager_icon="/home/zegu/.config/awesome/themes/openSUSE/icons/apps/file_manager.png"
theme.music_icon="/home/zegu/.config/awesome/themes/openSUSE/icons/apps/music_icon.png"
theme.idea_icon="/home/zegu/.config/awesome/themes/openSUSE/icons/apps/idea_icon.png"
theme.vscode_icon="/home/zegu/.config/awesome/themes/openSUSE/icons/apps/vscode_icon.png"
theme.win_icon ="/home/zegu/.config/awesome/themes/openSUSE/icons/apps/win.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/openSUSE/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/openSUSE/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/openSUSE/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/openSUSE/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/openSUSE/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/openSUSE/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/openSUSE/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/openSUSE/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/openSUSE/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/openSUSE/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/openSUSE/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/openSUSE/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.opensuse_icon = "/usr/share/awesome/themes/openSUSE/opensusegeeko.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = "Hey-classic-dark"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
