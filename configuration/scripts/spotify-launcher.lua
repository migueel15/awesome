local awful = require("awful")

awful.spawn.with_shell('spotify-launcher')
awful.spawn.with_shell("pkill spotify")

