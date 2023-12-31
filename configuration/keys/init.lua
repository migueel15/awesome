local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local app = require("configuration.apps")
local naughty = require("naughty")
local beautiful = require("beautiful")
local floating_terminal = require("configuration.utils.spawn_terminal_floating")
local modkey = "Mod4"

-- Mouse keys
awful.mouse.append_global_mousebindings({
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})

-- Keyboard keys
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Control" }, "Return", function()
    floating_terminal()
  end),

  awful.key(
    { modkey, "Control" },
    "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),

  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "Return", function() awful.spawn(app.terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, }, "w", function() awful.spawn(app.browser) end,
    { description = "open browser", group = "launcher" }),
  awful.key({ modkey, }, "v", function() awful.spawn(app.vscode) end,
    { description = "open vscode", group = "launcher" }),
  awful.key({ modkey, }, "o", function()
      awful.spawn(app.obsidian)
      awful.spawn.with_shell("sh ~/Scripts/IfObsidianOpen.sh")
    end,
    { description = "open obsidian", group = "launcher" }),
  awful.key({ modkey, }, "r", function() awful.spawn.with_shell(app.reminder) end,
    { description = "open reminder", group = "launcher" }),

  awful.key({ modkey, }, "y", function()
      awful.spawn.with_shell("sh ~/Scripts/YTDownloader.sh")
    end,
    { description = "download yt video", group = "launcher" }),
  awful.key({ modkey, }, "n", function()
      local tag = screen[1].tags[beautiful.tag_number + 1]
      tag:view_only()
      awful.screen.focus(1)
    end,
    { description = "open notion", group = "launcher" }),
  awful.key({ modkey }, "d", function()
    awful.spawn.with_shell(app.buscador)
  end),
  awful.key({ modkey }, "Escape", function() awful.spawn.with_shell(app.sysmenu) end),
  awful.key({ modkey, }, "c", function()
      awful.spawn.with_shell(app.calendar)
    end,
    { description = "run calendar", group = "launcher" }),
  awful.key({ modkey, }, "x", function() awful.spawn(app.chatgpt) end,
    { description = "run chatgpt", group = "launcher" }),
  awful.key({ modkey, }, "g", function() awful.spawn(app.github) end,
    { description = "run github", group = "launcher" }),

  awful.key({ modkey, "Control" }, "d", function()
      awful.spawn.with_shell(app.window_picker)
    end,
    { description = "run window_picker", group = "launcher" }),

  awful.key({ modkey }, "s", function()
      require("configuration.ui.rofi.search_spotlight").setup()
    end,
    { description = "search selector", group = "launcher" }),

  awful.key({ modkey, "Shift" }, "l",
    function()
      awful.spawn.with_shell("rm /tmp/startUp.txt")
      awful.spawn.with_shell("awesome-client 'awesome.quit()'")
      -- awesome.quit
    end,
    -- ,
    { description = "logout from awesome", group = "launcher" }),


  awful.key({ modkey }, "l",
    function()
      awful.spawn.with_shell("systemctl suspend")
    end,
    { description = "logout from awesome", group = "launcher" }),

  awful.key({ modkey, }, ".", function() awful.spawn(app.emoji) end,
    { description = "run rofi emoji", group = "launcher" }),
  awful.key({ modkey, }, "t", function() awful.spawn.with_shell(app.todo) end,
    { description = "run rofi todo", group = "launcher" }),
  awful.key({ modkey, "Control" }, "Delete", function() awful.spawn.with_shell("systemctl poweroff") end,
    { description = "shutdown system", group = "launcher" }),

  -- Layout keybindings
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, }, "Right", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, }, "Left", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Control" }, "k", function()
      if naughty.is_suspended() then
        awful.spawn.with_shell("polybar-msg action disturb hook 0")
      end
      if not naughty.is_suspended() then
        awful.spawn.with_shell("polybar-msg action disturb hook 1")
      end
      naughty.toggle()
    end,
    { description = "toggle notifications", group = "awesome" }),

  awful.key {
    modifiers   = { modkey },
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers   = { modkey, "Shift" },
    keygroup    = "numrow",
    description = "move focused client to tag",
    -- group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },

  -- Focus
  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),

  awful.key({ modkey, "Control" }, "b",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:activate { raise = true, context = "key.unminimize" }
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Display config and restart
  awful.key({ modkey, "Control" }, "l", function()
    require("configuration.utils.check-windows")
  end),
  -- Media buttons Keyboard
  awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end),
  awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl previous") end),
  awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end),
  awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("pamixer -i 5") end),
  awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("pamixer -d 5") end),
  awful.key({}, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl s 10%+") end),
  awful.key({}, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl s 10%-") end),
  awful.key({ "XF86WakeUp" }, "", function() awful.spawn("playerctl next") end),
  awful.key({}, "Print", function()
    awful.spawn("ksnip -r")
  end),

})

-- Client bindings
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey, }, "f",
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
      { description = "close", group = "client" }),

    awful.key({ modkey }, "space", awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
      { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "p", function(c) c:move_to_screen() end,
      { description = "move to screen", group = "client" }),

    awful.key({ modkey, "Control" }, "t", function(c)
        if (not c.sticky) then
          c.ontop = not c.ontop
        end
      end,
      { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey, "Shift" }, "s", function(c)
        c.sticky = not c.sticky
        if (not c.sticky) then
          c.ontop = false
          c.border_color = "#00000000"
          c.border_width = 0
        end
        if (c.sticky) then
          c.ontop = true
          c.border_color = "#ffffff"
          c.border_width = 2
        end
      end,
      { description = "toggle sticky prop", group = "client" }),

    awful.key({ modkey, }, "b",
      function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end,
      { description = "minimize", group = "client" }),

    awful.key({ modkey, }, "m",
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = "(un)maximize", group = "client" }),

    awful.key({ modkey, "Control" }, "m",
      function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      { description = "(un)maximize vertically", group = "client" }),

    awful.key({ modkey, "Shift" }, "m",
      function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      { description = "(un)maximize horizontally", group = "client" }),
  })
end)

-- Mouse bindings
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  })
end)
