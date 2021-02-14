-- freedesktop 
local freedesktop = require("freedesktop")
local beautiful = require("beautiful")
mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,

    after = {
        {"terminal", terminal, beautiful.terminal_icon},
        {"chrome", browser, beautiful.chrome_icon},
        {"file", filemanager, beautiful.file_manager_icon},
        {"music", music, beautiful.music_icon},
        {"vscode", vscode, beautiful.vscode_icon}
        -- other triads can be put here
    }
})

