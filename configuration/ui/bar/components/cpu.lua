local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local cmd = [[sh -c "vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'"]]
local cpuValue = awful.widget.watch(cmd, 1, function(widget, stdout)
  if stdout == nil then return end
  widget:set_text(string.format("%2d%%", 100 - math.floor(tonumber(stdout))))
end)

local cpu = wibox.widget {
  layout = wibox.container.margin,
  left = beautiful.widget_margin,
  {
    layout = wibox.layout.fixed.horizontal,
    {
      widget = wibox.container.background,
      fg = beautiful.colors.text,
      bg = beautiful.colors.primary,
      cpuValue
    },
    {
      widget = wibox.container.background,
      fg = beautiful.cpu.color,
      bg = beautiful.colors.primary,
      {
        widget = wibox.container.margin,
        left = beautiful.widget_text_icon_gap,
        {
          widget = wibox.widget.textbox,
          text = beautiful.cpu.icon,
        },
      },
    }
  }
}

return cpu
