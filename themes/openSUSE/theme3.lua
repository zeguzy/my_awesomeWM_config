------------------------------------------------------------
-- openSUSE awesome theme based on awesome default theme --
------------------------------------------------------------

theme = {}
-- load and prepare for use gtk theme:
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
    local gears_debug = require("gears.debug")
    gears_debug.print_warning("Can't load GTK+3 theme. Using 'xresources' theme as a fallback.")
    return theme
end
theme.gtk.button_border_radius = dpi(1)
theme.gtk.button_border_width = dpi(1.5)
theme.gtk.bold_font = theme.gtk.font_family .. ' Bold ' .. theme.gtk.font_size
theme.gtk.menubar_border_color = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.menubar_fg_color,
    0.7
)

theme.font          = "Dutcg801 RM BT 10"
theme.snap_bg       = "#428bca"
theme.snap_border_width =1
theme.bg_normal     = theme.gtk.bg_color
theme.fg_normal     = theme.gtk.fg_color

theme.systray_icon_spacing = 3
theme.wibar_bg      = theme.gtk.menubar_bg_color
theme.wibar_fg      = theme.gtk.menubar_fg_color

theme.bg_focus      = theme.gtk.selected_bg_color
theme.fg_focus      = theme.gtk.selected_fg_color

theme.bg_urgent     = theme.gtk.error_bg_color
theme.fg_urgent     = theme.gtk.error_fg_color

theme.bg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.3)
theme.fg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.9)

theme.bg_systray    = theme.wibar_bg
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_normal = theme.wibar_fg
theme.tasklist_bg_normal = "#bbb"
theme.tasklist_fg_focus = theme.tasklist_fg_normal
theme.tasklist_bg_focus = "#01579B"

theme.tasklist_font = theme.gtk.normal_font
theme.tasklist_font_focus = theme.gtk.bold_font
theme.tasklist_shape_border_color_minimized = mix(
    theme.bg_minimize,
    theme.fg_minimize,
    0.85
)
theme.tasklist_shape_border_width_minimized = theme.gtk.button_border_width

theme.tasklist_spacing = theme.gtk.button_border_width
theme.taglist_fg_focus    = "#000000"
--theme.taglist_fg_occupied = "#164b5d"
--theme.taglist_fg_urgent   = "#ED7572"
--theme.taglist_fg_empty    = "#828282"
theme.taglist_spacing     = 2
theme.taglist_font        = "ButterHaunted 13"
theme.taglist_bg_focus	  = "#01579B"

theme.titlebar_font_normal = theme.gtk.small_font
theme.titlebar_bg_normal = theme.gtk.wm_border_unfocused_color
theme.titlebar_fg_normal = theme.gtk.wm_title_focused_color
--theme.titlebar_fg_normal = choose_contrast_color(
    --theme.titlebar_bg_normal,
    --theme.gtk.menubar_fg_color,
    --theme.gtk.menubar_bg_color
--)


-- theme.titlebar_bg_focus                         =theme.gtk.wm_border_unfocused_color
theme.titlebar_bg_focus                         =theme.gtk.wm_border_unfocused_color
theme.titlebar_fg_focus                         = '#000000'
the
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
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load

theme.wallpaper = "/usr/share/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg"
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

theme.menu_border_width = theme.gtk.button_border_width
theme.menu_border_color = theme.gtk.menubar_border_color
theme.menu_bg_normal = theme.gtk.menubar_bg_color
theme.menu_fg_normal = theme.gtk.menubar_fg_color
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
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
