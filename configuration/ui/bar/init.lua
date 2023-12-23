local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local Widgets = require("configuration.ui.bar.components")
require("awful.autofocus")
local gears = require("gears")

screen.connect_signal("request::desktop_decoration", function(s)
  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen   = s,
    widget   = {
      layout = wibox.layout.stack,
      {
        layout = wibox.layout.align.horizontal,
        {
          layout = wibox.layout.fixed.horizontal,
          Widgets.workspace(s),
          Widgets.cpu,
          Widgets.ram,
          Widgets.disk
        },
        nil,
        {
          layout = wibox.layout.fixed.horizontal,
          Widgets.battery,
          Widgets.volume,
          Widgets.notifications,
          Widgets.bluetooth,
          --Widgets.logout,
          Widgets.systray,
        },
      },
      {
        Widgets.date,
        valign = "center",
        halign = "center",
        layout = wibox.container.place
      }
    }
  }
end)
