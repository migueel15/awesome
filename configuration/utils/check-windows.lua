local awful = require("awful")

awful.spawn.easy_async_with_shell("autorandr", function(out)
  local detected = string.find(out, "DockedOnly (detected)")
  if detected then
    awful.spawn("autorandr -c")
  else
    awful.spawn.easy_async_with_shell("autorandr -l Laptop", function()
      awful.spawn("autorandr -c")
    end)
  end
end)
