local beautiful = require("beautiful")
local rofi_path = os.getenv("HOME") .. "/.config/awesome/configuration/ui/rofi"

local colors = beautiful.colors

local rasiColorsheme = string.format([[
  * {
    primary:   %s;
    secondary: %s;
    text:      %s;
  }
]], colors.primary, colors.secondary, colors.text)

local file = io.open(rofi_path .. "/colors.rasi", "w")
if file == nil then return end
file:write(rasiColorsheme)
file:close()
