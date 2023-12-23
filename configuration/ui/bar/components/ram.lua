local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local cmd = [[sh -c "free -m | grep 'Mem:' | awk '{printf \"%d,%d\", $3, $2}'"]]
local ramValues = awful.widget.watch(cmd, 1, function(widget, stdout)
  local used, total = stdout:match('([^,]+),([^,]+)')
  widget:set_text(string.format("%2d%%", math.floor((used / total) * 100)))
end)

local ram = wibox.widget {
  layout = wibox.container.margin,
  left = beautiful.widget_margin,
  {
    layout = wibox.layout.fixed.horizontal,
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.colors.text,
      ramValues
    },
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.ram.color,
      {
        widget = wibox.container.margin,
        left = beautiful.widget_text_icon_gap,
        {
          widget = wibox.widget.textbox,
          text = beautiful.ram.icon,
        },
      },
    },
  }
}

return ram
