local awful = require("awful")
function spawn_terminal_floating()
  awful.spawn.with_shell("kitty --title=floating-terminal", false, function(c)
  end)
end

return spawn_terminal_floating
