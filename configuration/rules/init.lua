local ruled = require("ruled")
local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
-----------------------
------- CLIENTS -------
-----------------------

ruled.client.connect_signal("request::rules", function(c)
  if screen[2] then
    -- Screen 2
    ruled.client.append_rule {
      rule = {
        class = "whatsapp"
      },
      properties = {
        tag = screen[2].tags[5]
      }
    }
    ruled.client.append_rule {
      rule = {
        class = "discord"
      },
      properties = {
        tag = screen[2].tags[5]
      }
    }
    ruled.client.append_rule {
      rule = {
        class = "Spotify"
      },
      properties = {
        tag = screen[2].tags[6]
      }
    }
  else
    -- Screen 1
    ruled.client.append_rule {
      rule = {
        class = "whatsapp"
      },
      properties = {
        tag = screen[1].tags[5]
      }
    }
    ruled.client.append_rule {
      rule = {
        class = "discord"
      },
      properties = {
        tag = screen[1].tags[5]
      }
    }
    ruled.client.append_rule {
      rule = {
        class = "Spotify"
      },
      properties = {
        tag = screen[1].tags[6]
      }
    }
  end

  ruled.client.append_rule {
    rule = {
      class = "calculator"
    },
    properties = {
      floating = true,
      ontop = true
    }
  }


  -- Picture in picture in all tags
  ruled.client.append_rule {
    rule = {
      class = "firefox",
      instance = "Toolkit"
    },
    properties = {
      sticky = true,
      ontop = true
    }
  }

  -- ScreenShot
  ruled.client.append_rule {
    rule = {
      class = "ksnip",
    },
    properties = {
      floating = true,
      sticky = true,
      ontop = true
    }
  }

  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }

  ruled.client.append_rule {
    rule = {
      name = "floating-terminal"
    },
    properties = {
      floating     = true,
      ontop        = true,
      width        = 640,
      height       = 480,
      border_color = beautiful.colors.secondary,
      placement    = awful.placement.centered,
    }
  }

  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = { "copyq", "pinentry" },
      class    = {
        "Arandr", "blueman-manager", "Gpick", "Kruler", "Sxiv",
        "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }
end)

-----------------------
---- NOTIFICATIONS ----
-----------------------

ruled.notification.connect_signal('request::rules', function()
  ruled.notification.append_rule {
    rule       = { urgency = "normal" },
    properties = {
      fg               = beautiful.colors.text,
      screen           = awful.screen.preferred,
      implicit_timeout = 5,
      border_width     = 4,
      margin           = 10,
      bg               = beautiful.colors.primary,
      border_color     = beautiful.colors.secondary,
      font             = beautiful.font,
    },
  }

  ruled.notification.append_rule {
    rule       = { category = "custom" },
    properties = {
      title            = [[<b>Notificación</b>]],
      fg               = beautiful.colors.text,
      icon             = "/usr/share/awesome/icons/awesome64.png",
      screen           = awful.screen.preferred,
      implicit_timeout = 5,
      border_width     = 4,
      margin           = 10,
      bg               = beautiful.colors.primary,
      border_color     = beautiful.colors.secondary,
      font             = beautiful.font,
    },
    callback   = function()
      if not naughty.is_suspended() then
        awful.spawn.with_shell("paplay /usr/share/sounds/freedesktop/stereo/bell.oga")
      end
    end
  }

  ruled.notification.append_rule {
    rule       = { category = "notion-event" },
    properties = {
      fg               = beautiful.colors.text,
      icon             = gears.color.recolor_image(
        os.getenv("HOME") .. "/.config/awesome/configuration/theme/icons/notion-logo.svg", beautiful
        .colors.secondary),
      screen           = awful.screen.preferred,
      implicit_timeout = 0,
      border_width     = 4,
      margin           = 10,
      bg               = beautiful.colors.primary,
      border_color     = beautiful.colors.secondary,
      font             = beautiful.font,
    },
    callback   = function()
      if not naughty.is_suspended() then
        awful.spawn.with_shell("paplay /usr/share/sounds/freedesktop/stereo/bell.oga")
      end
    end
  }
end)

function StoreNotification(notification)
  local title = notification.title
  local message = notification.message
  local time = os.date("%Y-%m-%d %H:%M:%S")

  local output = string.format("%s: %s, %s", title, message, time)
  awful.spawn(string.format("echo '%s' >> /tmp/notifications_log.txt", output))
end

naughty.connect_signal("request::display", function(n)
  if (n.app_name == "discord") then
    n.title = "<b>Discord</b>"
  elseif (n.app_name == "whatsapp-nativefier-d40211") then
    n.title = "<b>" .. n.title .. "</b>"
  else
    --n.title = "<b>Notificación</b>"
  end

  naughty.layout.box { notification = n }
  StoreNotification(n)
end)

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)

-----------------------
-------- MOUSE --------
-----------------------

client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)
