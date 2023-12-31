local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local modkey = "Mod4"

function SetWorkspace(s)
  local icons = {}
  for i = 1, beautiful.tag_number do
    table.insert(icons, beautiful.tag.icon)
  end

  awful.tag(icons, s, awful.layout.suit.tile)

  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,

    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
  }
  return wibox.widget {
    widget = wibox.container.margin,
    left = beautiful.widget_margin,
    s.mytaglist
  }
end

return SetWorkspace
