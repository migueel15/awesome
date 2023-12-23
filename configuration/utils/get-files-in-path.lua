local lfs = require("lfs")

-- Function to get all files in a folder
function getAllFilesInFolder(folderPath)
  local files = {}

  for file in lfs.dir(folderPath) do
    if file ~= "." and file ~= ".." then
      local filePath = folderPath .. "/" .. file
      local attributes = lfs.attributes(filePath)

      if attributes.mode == "file" then
        file = file:gsub("%.lua$", "")
        table.insert(files, file)
      end
    end
  end

  return files
end

return getAllFilesInFolder
