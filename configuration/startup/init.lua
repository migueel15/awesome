local awful = require("awful")
local app = require("configuration.apps")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")


-- Start only at login
local pathFile = "/tmp/startUp.txt"

if not gears.filesystem.file_readable(pathFile) then
  local command = "echo started > " .. pathFile
  awful.spawn.with_shell(command)
  require("configuration.utils.check-windows")

  awful.spawn(app.solaar)
  awful.spawn(app.mpris)
  awful.spawn(app.picom)
  awful.spawn.with_shell("~/Scripts/SyncDotfiles.sh")

  local notion = awful.spawn(app.notion, {
    tag = screen[1].tags[beautiful.tag_number + 1],
  })
  -- Open notion (own firefox profile in main monitor, last tag)
end


awful.spawn(app.discord)
--awful.spawn(app.whatsapp)
awful.spawn(app.networkManager)
