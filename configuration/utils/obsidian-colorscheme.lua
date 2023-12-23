function setObsidianTheme(theme, path)
  local makeAbsolutePath = require("configuration.utils.path-to-absolute")
  path = makeAbsolutePath(path)
  local json = require("dkjson")
  local file = io.open(path .. "/.obsidian/appearance.json", "r")

  if file then
    local jsonData = file:read("*a")
    file:close()

    local settings = json.decode(jsonData)
    settings["cssTheme"] = theme

    local modifiedVersion = json.encode(settings, { indent = true })

    local outFile = io.open(path .. "/.obsidian/appearance.json", "w")
    if outFile then
      outFile:write(modifiedVersion)
      outFile:close()
    end
  end
end

return setObsidianTheme
