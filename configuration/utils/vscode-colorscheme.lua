function setVSCodeTheme(theme)
  local json = require("dkjson")
  local file = io.open(os.getenv("HOME") .. "/.config/Code/User/settings.json", "r")

  if file then
    local jsonData = file:read("*a")
    file:close()

    local settings = json.decode(jsonData)
    settings["workbench.colorTheme"] = theme

    local modifiedVersion = json.encode(settings, { indent = true })

    local outFile = io.open(os.getenv("HOME") .. "/.config/Code/User/settings.json", "w")
    if outFile then
      outFile:write(modifiedVersion)
      outFile:close()
    end
  end
end

return setVSCodeTheme
