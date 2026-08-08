#!/usr/bin/env bash

set -u

dir="$HOME/.config/rofi"
theme="$dir/powermenu.rasi"
host="$(hostname)"
uptime_text="$(uptime -p | sed 's/^up //')"

shutdown=' Power Off'
reboot=' Reboot'
suspend=' Suspend'
logout='󰍃 Logout'
yes=' Yes'
no=' No'

rofi_menu() {
  rofi -no-config \
    -dmenu \
    -p "$host" \
    -theme "$theme" \
    -theme-str "textbox-uptime { str: \"Uptime: $uptime_text\"; }"
}

confirm() {
  printf '%s\n%s\n' "$yes" "$no" | rofi -no-config \
    -dmenu \
    -p 'Confirmation' \
    -mesg "${1}?" \
    -theme "$theme" \
    -theme-str 'window { width: 300px; }' \
    -theme-str 'mainbox { children: [ "message", "listview" ]; }' \
    -theme-str 'listview { columns: 2; lines: 1; }'
}

confirmed() {
  [[ "$(confirm "$1")" == "$yes" ]]
}

choice="$(printf '%s\n%s\n%s\n%s\n' \
  "$logout" "$suspend" "$reboot" "$shutdown" | rofi_menu)"

case "$choice" in
"$logout")
  confirmed 'Log out of Hyprland' && hyprctl dispatch 'hl.dsp.exit()'
  ;;
"$suspend")
  confirmed 'Suspend the system' && systemctl suspend
  ;;
"$reboot")
  confirmed 'Reboot the system' && systemctl reboot
  ;;
"$shutdown")
  confirmed 'Power off the system' && systemctl poweroff
  ;;
esac
