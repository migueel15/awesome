local Widgets = {}

Widgets.systray = require("configuration.ui.bar.components.systray")
Widgets.date = require("configuration.ui.bar.components.date")
Widgets.cpu = require("configuration.ui.bar.components.cpu")
Widgets.ram = require("configuration.ui.bar.components.ram")
Widgets.disk = require("configuration.ui.bar.components.diskUsage")
Widgets.bluetooth = require("configuration.ui.bar.components.bluetooth")
Widgets.battery = require("configuration.ui.bar.components.battery")
Widgets.volume = require("configuration.ui.bar.components.volume")
Widgets.notifications = require("configuration.ui.bar.components.notifications")
Widgets.workspace = require("configuration.ui.bar.components.workspace")
Widgets.logout = require("configuration.ui.bar.components.logout")

return Widgets
