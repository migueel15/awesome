local wibox = require("wibox")
local beautiful = require("beautiful")
local textclock = wibox.widget.textclock("%a %d %b - %H:%M")

local date = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    fg = beautiful.date.color,
    {
      widget = wibox.widget.textbox,
      text = beautiful.date.icon,
    },
  },
  {
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    fg = beautiful.colors.text,
    {
      widget = wibox.container.margin,
      left = beautiful.widget_text_icon_gap,
      textclock,
    },
  }
}

return date
