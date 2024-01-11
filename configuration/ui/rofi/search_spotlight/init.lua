local awful = require("awful")
local app = require("configuration.apps")

local M = {}

M.options =

{
  ["pages"] = {
    ["google"] = {
      ["url"] = "https://www.google.com/search?q=",
      ["icon"] = "..."
    },
    ["github"] = {
      ["url"] = "https://github.com/search?type=repositories&q=",
      ["icon"] = "..."
    },
    ["youtube"] = {
      ["url"] = "https://www.youtube.com/results?search_query=",
      ["icon"] = "..."
    },
    ["twitch"] = {
      ["url"] = "https://www.twitch.tv/",
      ["icon"] = "..."
    },
    ["reddit"] = {
      ["url"] = "https://www.reddit.com/search/?q=",
      ["icon"] = "..."
    },
    ["twitter"] = {
      ["url"] = "https://twitter.com/search?src=typed_query&q=",
      ["icon"] = "..."
    }
  }
}

M.keys = {}
for key, _ in pairs(M.options["pages"]) do
  table.insert(M.keys, key)
end

M._string_keys = "echo '" .. table.concat(M.keys, "\n") .. "'"

M.setup = function()
  awful.spawn.easy_async_with_shell(
    M._string_keys ..
    " | rofi -theme ~/.config/awesome/configuration/ui/rofi/search_spotlight/selector.rasi -dmenu -p 'Search Engine' -matching fuzzy",
    function(engine)
      engine = string.gsub(engine, "%s", "")
      awful.spawn.easy_async_with_shell(
        "rofi -theme ~/.config/awesome/configuration/ui/rofi/search_spotlight/search.rasi -dmenu -p " ..
        engine, function(query)
          if string.len(string.gsub(engine, "%s", "")) ~= 0 and string.len(string.gsub(query, "%s", "")) ~= 0 then
            local full_query = M.options["pages"][engine]["url"] .. query
            --naughty.notify({ text = "Searching on " .. engine .. "...", category = "custom" })
            awful.spawn(app.browser .. " '" .. full_query .. "'")
          end
        end
      )
    end)
end

return M
