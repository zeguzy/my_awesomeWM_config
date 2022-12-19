local awful = require("awful")
local wibox = require("wibox")


local my_textclock = {}

local function worker(user_args)

  my_textclock =  wibox.widget {
    {
        id = "time",
        format = '%Y-%m-%d %H:%M  ',
        widget = wibox.widget.textclock,
    },
    layout = wibox.layout.fixed.horizontal,
  }

  my_textclock:buttons(
    awful.util.table.join(
      awful.button({}, 1, function()
      end),
      awful.button({}, 3, function()
        awful.spawn.with_shell('date "+%Y-%m-%d %H:%M" | xsel -i -b')
      end)
    )
  )


  return my_textclock

end

return setmetatable(my_textclock, { __call = function(_, ...)
  return worker(...)
end })
