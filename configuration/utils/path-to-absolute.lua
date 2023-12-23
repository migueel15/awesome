function makeAbsolutePath(path)
    if path:sub(1, 2) == "~/" then
        local homeDir = os.getenv("HOME")        
        if homeDir then
            path = homeDir .. path:sub(2)
        else
            return nil, "HOME environment variable not found"
        end
    end

    if not path:match("^/") then
        local cwd = io.popen("pwd"):read("*l")
        path = cwd .. "/" .. path
    end

    return path
end

return makeAbsolutePath
