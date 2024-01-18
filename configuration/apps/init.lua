local rofi = "~/.config/awesome/configuration/ui/rofi/"

local app = {}

app.terminal = "kitty"
app.editor = os.getenv("EDITOR") or "nano"
app.editor_cmd = app.terminal .. " -e " .. app.editor
app.vscode = "code"
app.todoist = "todoist"
app.browser = "firefox"
app.locker = "~/Scripts/LockScreen.sh"
app.sysmenu = rofi .. "powermenu.sh &"
app.obsidian = "obsidian"

app.notion = "firefox https://notion.so"
app.create_notion_task = "~/.config/awesome/configuration/ui/rofi/notion/create_task.sh"

app.discord = "discord"
app.whatsapp = "whatsapp-nativefier"
app.detectScreen = "autorandr -c"
app.solaar = "solaar --window=hide"
app.mpris = "mpris-proxy"
app.calendar = app.browser .. " https://calendar.notion.so/"
app.chatgpt = app.browser .. " https://chat.openai.com/chat"
app.github = app.browser .. " https://github.com/migueel15"
app.buscador = "rofi -no-config -no-lazy-grab -show drun -modi drun -theme " .. rofi .. "launcher.rasi"
app.emoji = "rofi -modi emoji -show emoji -emoji-format '{emoji}' -theme " .. rofi .. "emojis.rasi"
app.screenshot = "shutter -s"
app.reminder = "~/Scripts/reminder.sh"
app.todo = "~/Scripts/todos/todo.sh"
app.bluetooth = "blueberry"
app.networkManager = "nm-applet"
app.picom = "picom"
app.autorandrDual = "autorandr -l DockedOnly"
app.window_picker = "rofi -show window -matching fuzzy -theme " .. rofi .. "actual_windows.rasi"

return app
