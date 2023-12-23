local awful = require("awful")
local app = require("configuration.apps")
local gears = require("gears")


-- Start only at login
local pathFile = "/tmp/startUp.txt"

if not gears.filesystem.file_readable(pathFile) then
  local command = "echo started > " .. pathFile
  awful.spawn.with_shell(command)

  require("configuration.scripts.spotify-launcher")
  awful.spawn(app.notion)
  awful.spawn(app.solaar)
  awful.spawn(app.mpris)
  awful.spawn(app.picom)
  awful.spawn.with_shell("~/Scripts/SyncDotfiles.sh")
end

awful.spawn(app.discord)
--awful.spawn(app.whatsapp)
awful.spawn(app.networkManager)
