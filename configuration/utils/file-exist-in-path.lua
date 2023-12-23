local valores = require("configuration.utils.get-files-in-path")

function tableContainsValue(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

return tableContainsValue
