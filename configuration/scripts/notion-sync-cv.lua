local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")

gears.timer {
  timeout = 1800, -- 30 minutes
  autostart = true,
  call_now = true,
  callback = function()
    awful.spawn.with_shell("/usr/bin/node ~/Repositorios/Notion-Sync-CampusVirtual/src/main.js")
  end
}
