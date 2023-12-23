local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local cmd = [[sh -c "df -H / | grep "/" | awk '{printf \"%d\", $4}'"]]
local diskUsage = awful.widget.watch(cmd, 300, function(widget, stdout)
  widget:set_text(string.format("%2dGb", stdout))
end)

local disk = wibox.widget {
  layout = wibox.container.margin,
  left = beautiful.widget_margin,
  {
    layout = wibox.layout.fixed.horizontal,
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.colors.text,
      diskUsage
    },
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.disk.color,
      {
        widget = wibox.container.margin,
        left = beautiful.widget_text_icon_gap,
        {
          widget = wibox.widget.textbox,
          text = beautiful.disk.icon
        },
      },
    },
  }
}


return disk
