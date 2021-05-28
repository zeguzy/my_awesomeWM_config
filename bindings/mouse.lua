-- 鼠标绑定
local gears = require("gears")
local awful = require("awful")

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3,
        --function() mymainmenu:toggle() end)
        function()  end)
    ,awful.button({modkey}, 4,function() awful.spawn(previousWallpaper) end)
    ,awful.button({modkey}, 5,function() awful.spawn(nextWallpaper) end) 
        ))
-- }}}
