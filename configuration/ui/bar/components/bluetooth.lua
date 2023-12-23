local wibox     = require("wibox")
local beautiful = require("beautiful")
local gears     = require("gears")
local app       = require("configuration.apps")
local awful     = require("awful")
local naughty   = require("naughty")

local enabled   = true
local connected = false
local Icon      = ""
local Color     = ""

function CheckEnable()
  awful.spawn.easy_async_with_shell("bluetoothctl show | grep 'Powered: yes'", function(command)
    if (command == nil) then return end
    if command == "" then
      enabled = false
    else
      enabled = true
    end
  end)
end

function CheckConnected()
  awful.spawn.easy_async_with_shell("bluetoothctl info | grep 'Connected: yes'", function(command)
    if (command == nil) then return end
    if command == "" then
      connected = false
    else
      connected = true
    end
  end)
end

function SetValues(widget)
  CheckEnable()
  CheckConnected()

  if enabled then
    if connected then
      Color = beautiful.bluetooth_connected.color
    else
      Color = beautiful.bluetooth_enable.color
    end
    Icon = beautiful.bluetooth_enable.icon
  else
    Icon = beautiful.bluetooth_disable.icon
    Color = beautiful.bluetooth_disable.color
  end

  -- overwrite values in widgets
  if (widget == nil) then return end
  widget.children[1].children[1].children[1].text = Icon
  widget.children[1].fg = Color
end

SetValues()

local bluetooth = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.container.background,
    bg = beautiful.colors.primary,
    fg = Color,
    {
      widget = wibox.container.margin,
      left = beautiful.widget_margin,
      {
        widget = wibox.widget.textbox,
        text = Icon,
      }
    },
  }
}
bluetooth:connect_signal("button::press", function(_, _, _, button)
  -- this is handle in signals folder
  if button == 1 then -- left click
    awful.spawn(app.bluetooth)
  end
  if button == 3 then -- right click
    if enabled then
      awful.spawn.with_shell("bluetoothctl power off")
    else
      awful.spawn.with_shell("bluetoothctl power on")
    end
  end
end)

gears.timer {
  timeout = 1,
  autostart = true,
  call_now = true,
  callback = function()
    SetValues(bluetooth)
  end
}

return bluetooth
