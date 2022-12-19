local awful = require("awful")
local wibox = require("wibox")
local awesomebuttons = require("awesome-buttons.awesome-buttons")



local my_textclock = {}

local function worker(user_args)

  local date = awesomebuttons.with_icon_and_date({
    icon = 'calendar',
    type = 'outline',
    onclick = function()
      awful.spawn.with_shell('alacritty -e calcurse')
    end
  })

  -- date:buttons(
  --   awful.util.table.join(
  --     awful.button({}, 3, function()
  --       awful.spawn.with_shell('date "+%Y-%m-%d %H:%M" | xsel -i -b')
  --     end)
  --   )
  -- )

  local time = awesomebuttons.with_icon_and_date({
    format = "%H:%M",
    type = 'outline',
    icon = 'clock',
    onclick = function()
      awful.spawn.with_shell('date "+%Y-%m-%d %H:%M" | xsel -i -b')
    end
  })

  -- time:buttons(
  --   awful.util.table.join(
  --     awful.button({}, 1, function()
  --       awful.spawn.with_shell('date "+%Y-%m-%d %H:%M" | xsel -i -b')
  --     end)
  --   )
  -- )

  my_textclock = wibox.widget {
    date, 
    time,
    layout = wibox.layout.fixed.horizontal,
  }


  return my_textclock

end

return setmetatable(my_textclock, { __call = function(_, ...)
  return worker(...)
end })
