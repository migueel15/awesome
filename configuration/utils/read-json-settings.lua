function getSettings()
  local json = require("dkjson")
  local file = io.open(os.getenv("HOME") .. "/.config/awesome/configuration/settings.json", "r")
  local jsonData = {}

  if file then
    jsonData = file:read("*a")
    file:close()
    local inJson = json.decode(jsonData)
    if inJson  then
      jsonData = inJson
    end
  end

  return jsonData
end

return getSettings()

