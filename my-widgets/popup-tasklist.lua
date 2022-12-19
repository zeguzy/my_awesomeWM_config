local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local awesomebuttons = require("awesome-buttons.awesome-buttons")

local taglist_buttons =
gears.table.join(
  awful.button(
    {},
    1,
    function(t)
      t:view_only()
    end
  ),
  awful.button(
    { modkey },
    1,
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end
  ),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button(
    { modkey },
    3,
    function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end
  ),
  awful.button(
    {},
    4,
    function(t)
      awful.tag.viewnext(t.screen)
    end
  ),
  awful.button(
    {},
    5,
    function(t)
      awful.tag.viewprev(t.screen)
    end
  )
)
local popup_tasklist = {}


local popup = awful.popup {
  widget       = awful.widget.tasklist {
    screen          = screen[1],
    -- filter          = awful.widget.tasklist.filter.allscreen,
    filter          = awful.widget.tasklist.filter.currenttags,
    -- buttons         = taglist_buttons,
    style           = {
      shape = gears.shape.rounded_rect,
    },
    layout          = {
      spacing = 15,
      forced_num_rows = 1,
      layout = wibox.layout.grid.horizontal
    },
    widget_template = {
      {
        {
          id     = "clienticon",
          widget = awful.widget.clienticon,
        },
        margins = 4,
        widget  = wibox.container.margin,
      },
      id              = "background_role",
      forced_width    = 64,
      forced_height   = 64,
      fg              = '#000000',
      opacity         = 0.5,
      widget          = wibox.container.background,
      create_callback = function(self, c, index, objects) --luacheck: no unused
        self:get_children_by_id("clienticon")[1].client = c
      end,
    },
  },
  border_color = "#777777",
  border_width = 2,
  ontop        = true,
  placement    = awful.placement.centered,
  shape        = gears.shape.rounded_rect,
  visible      = false,
}




local function worker(user_args)

  local btn = awesomebuttons.with_icon_and_text({
    icon = "grid",
    text = "tasklist",
    onclick = function()
      popup.visible = not popup.visible
    end
  })

  popup_tasklist = btn


  popup_tasklist.show = function()
    popup.visible = true
  end
  popup_tasklist.hide = function()
    popup.visible = false
  end


  return popup_tasklist
end

return setmetatable(popup_tasklist, { __call = function(_, ...)
  return worker(...)
end })
