local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local currentIcon = ""
local currentColor = ""

local cmd =
[[sh -c "upower -i /org/freedesktop/UPower/devices/battery_BAT0"]]


local batteryText = wibox.widget {
  widget = wibox.widget.textbox,
}

local battery = wibox.widget {
  layout = wibox.container.margin,
  left = beautiful.widget_margin,
  {
    layout = wibox.layout.fixed.horizontal,
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.colors.text,
      {
        widget = wibox.container.margin,
        batteryText,
      },
    },
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.colors.secondary,
      {
        widget = wibox.container.margin,
        left = beautiful.widget_text_icon_gap,
        {
          widget = wibox.widget.textbox,
          text = currentIcon,
        },
      },
    },
  }
}

function getValues(data)
  return tonumber(data:match("percentage:%s*(%d*)%%")), data:match("state:%s*(%a*)")
end

local batValue = awful.widget.watch(cmd, 1, function(widget, stdout)
  local percentage, state = getValues(stdout)

  if state == "discharging" then
    if percentage >= 80 then
      currentIcon = beautiful.battery_full.icon
      currentColor = beautiful.battery_full.color
    elseif percentage >= 60 then
      currentIcon = beautiful.battery_three.icon
      currentColor = beautiful.battery_three.color
    elseif percentage >= 40 then
      currentIcon = beautiful.battery_half.icon
      currentColor = beautiful.battery_half.color
    elseif percentage >= 20 then
      currentIcon = beautiful.battery_quarter.icon
      currentColor = beautiful.battery_quarter.color
    else
      currentIcon = beautiful.battery_empty.icon
      currentColor = beautiful.battery_empty.color
    end
  else
    currentIcon = beautiful.battery_charging.icon
    currentColor = beautiful.battery_charging.color
  end


  battery.children[1].children[2].fg = currentColor
  battery.children[1].children[2].children[1].children[1].text = currentIcon
  batteryText:set_text(string.format("%2d%%", math.floor(percentage)))
end)

return battery
