local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local currentIcon = ""
local currentColor = ""

local cmd =
[[sh -c "pamixer --get-volume"]]


local volumeText = wibox.widget {
  widget = wibox.widget.textbox,
}

local volume = wibox.widget {
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
        volumeText,
      },
    },
    {
      widget = wibox.container.background,
      bg = beautiful.colors.primary,
      fg = beautiful.volume_high.color,
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

volume:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn("pavucontrol")
  elseif button == 3 then
    awful.spawn("pamixer -t")
  elseif button == 4 then
    awful.spawn("pamixer -i 5")
  elseif button == 5 then
    awful.spawn("pamixer -d 5")
  end
end)

awful.widget.watch(cmd, 0.1, function(widget, stdout)
  local vol = tonumber(stdout)
  if vol == nil then return end

  awful.spawn.easy_async_with_shell(
    "pamixer --get-mute",
    function(stdout)
      if stdout:match("true") then
        currentIcon = beautiful.volume_muted.icon
        currentColor = beautiful.volume_muted.color
      else
        if vol >= 70 then
          currentIcon = beautiful.volume_high.icon
          currentColor = beautiful.volume_high.color
        elseif vol >= 30 then
          currentIcon = beautiful.volume_medium.icon
          currentColor = beautiful.volume_medium.color
        elseif vol >= 0 then
          currentIcon = beautiful.volume_low.icon
          currentColor = beautiful.volume_low.color
        else
          currentIcon = beautiful.volume_muted.icon
          currentColor = beautiful.volume_muted.color
        end
      end

      volume.children[1].children[2].fg = currentColor
      volume.children[1].children[2].children[1].children[1].text = currentIcon
      volumeText:set_text(string.format("%2d%%", math.floor(vol)))
    end
  )
end)

return volume
