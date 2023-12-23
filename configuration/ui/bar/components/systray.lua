local wibox = require("wibox")
local beautiful = require("beautiful")

local systray = wibox.widget {
  widget = wibox.widget.systray(),
  base_size = 25,
}
-- systray.base_size = 25
return wibox.widget {
  widget = wibox.container.margin,
  left = beautiful.widget_margin,
  right = beautiful.widget_margin,
  {
    widget = wibox.container.place,
    valign = 'center',
    halign = "center",
    systray,
  }
}
