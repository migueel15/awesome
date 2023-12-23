local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")

local currentIcon = ""
local currentColor = ""


local notification = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.bg_normal,
  fg = beautiful.notification.color,
  {
    widget = wibox.container.margin,
    left = beautiful.widget_margin,
    {
      widget = wibox.widget.textbox,
      text = currentIcon,
    },
  },
}

gears.timer {
  timeout = 1,
  call_now = true,
  autostart = true,
  callback = function()
    if naughty.is_suspended() then
      currentIcon = beautiful.notification_disable.icon
      currentColor = beautiful.notification_disable.color
    else
      currentIcon = beautiful.notification.icon
      currentColor = beautiful.notification.color
    end

    notification.children[1].children[1].text = currentIcon
    notification.fg = currentColor
  end,
}

notification:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    naughty.toggle()
  end
end)

return notification
