local beautiful = require("beautiful")
local gears = require("gears")

screen.connect_signal("request::wallpaper", function(s)
  gears.wallpaper.maximized(beautiful.wallpaper, s, false)
end)
