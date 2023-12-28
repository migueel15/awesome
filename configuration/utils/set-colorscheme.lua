local settings = require("configuration.utils.read-json-settings")
local colorscheme = settings.theme
local theme = {}

local check = require("configuration.utils.file-exist-in-path")
local opciones = require("configuration.utils.get-files-in-path")(os.getenv("HOME") ..
  "/.config/awesome/configuration/theme/colorschemes")

local check = check(opciones, colorscheme)
if check then
  theme = require("configuration.theme.colorschemes." .. colorscheme)
else
  theme = require("configuration.theme.colorschemes.default")
end

if settings.vscodeTheme then
  local setVSCodeTheme = require("configuration.utils.vscode-colorscheme")
  setVSCodeTheme(theme.vscode)
end

if settings.obsidianTheme then
  local setObsidianTheme = require("configuration.utils.obsidian-colorscheme")
  setObsidianTheme(theme.obsidian, settings.obsidianPath)
end

if settings.alacrittyTheme then
  local setAlacrittyTheme = require("configuration.utils.alacritty-colorscheme")
  setAlacrittyTheme(theme.colors, settings.alacrittyPath)
end

return theme

