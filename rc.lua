pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

----------------------------------------------
---- CUSTOM LIBRARIES ------------------------
----------------------------------------------
beautiful.init(gears.filesystem.get_configuration_dir() .. "configuration/theme/theme.lua")

require("configuration.ui")
require("configuration.keys")
require("configuration.rules")
require("configuration.signals")
require("configuration.scripts")
require("configuration.utils")
require("configuration.startup")
