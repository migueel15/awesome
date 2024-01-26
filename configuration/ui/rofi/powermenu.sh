dir="~/.config/awesome/configuration/ui/rofi"
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="rofi -no-config -theme $dir/powermenu.rasi -hover-select"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"


# Variable passed to rofi
options="$suspend\n$logout\n$reboot\n$shutdown\n$lock"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
			systemctl poweroff
        ;;
    $reboot)
			systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
			mpc -q pause
			amixer set Master mute
			systemctl suspend
        ;;
    $logout)
    	awesome-client "awesome.quit()"
        ;;
esac
