function setAlacrittyTheme(colors, path)  
  local lyaml = require("lyaml")
  local path = require("configuration.utils.path-to-absolute")(path)
  
  local file = io.open(path, "r")

  os.setlocale("C")
  local contents = file:read("*all")
  file:close()

  local alacritty = lyaml.load(contents)

  alacritty.colors.primary.background = colors.primary
  alacritty.colors.primary.foreground = colors.white
  alacritty.colors.primary.dim_foreground = colors.grey
  alacritty.colors.cursor.text = colors.primary
  alacritty.colors.cursor.cursor = colors.white

  alacritty.colors.normal.black = colors.dark
  alacritty.colors.normal.red = colors.red
  alacritty.colors.normal.green = colors.green
  alacritty.colors.normal.yellow = colors.yellow
  alacritty.colors.normal.blue = colors.blue
  alacritty.colors.normal.magenta = colors.magenta
  alacritty.colors.normal.cyan = colors.cyan
  alacritty.colors.normal.white = colors.white

  alacritty.colors.bright.black = colors.dark
  alacritty.colors.bright.red = colors.red
  alacritty.colors.bright.green = colors.green
  alacritty.colors.bright.yellow = colors.yellow
  alacritty.colors.bright.blue = colors.blue
  alacritty.colors.bright.magenta = colors.magenta
  alacritty.colors.bright.cyan = colors.cyan
  alacritty.colors.bright.white = colors.white

  alacritty.colors.dim.black = colors.dark
  alacritty.colors.dim.red = colors.red
  alacritty.colors.dim.green = colors.green
  alacritty.colors.dim.yellow = colors.yellow
  alacritty.colors.dim.blue = colors.blue
  alacritty.colors.dim.magenta = colors.magenta
  alacritty.colors.dim.cyan = colors.cyan
  alacritty.colors.dim.white = colors.white

  contents = lyaml.dump({alacritty})

  file = io.open(path, "w")
  file:write(contents)
  file:close()

end

-- local colors      = {}

-- colors.green      = "#98971a"
-- colors.cyan       = "#83a598"
-- colors.blue       = "#458588"
-- colors.magenta    = "#b16286"
-- colors.yellow     = "#d79921"
-- colors.orange     = "#d65d0e"
-- colors.red        = "#cc241d"
-- colors.white      = "#ebdbb2"
-- colors.grey       = "#928374"
-- colors.darkGrey   = "#3c3836"
-- colors.dark       = "#282828"

-- colors.primary    = colors.dark
-- colors.secondary  = colors.blue
-- colors.text       = colors.grey
-- colors.tag_focus  = colors.white

-- setAlacrittyTheme(colors, os.getenv("HOME") .. "/.config/alacritty/alacritty.yml")

return setAlacrittyTheme
