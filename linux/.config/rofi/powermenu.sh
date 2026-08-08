#!/usr/bin/env bash

set -u

dir="$HOME/.config/rofi"
theme="$dir/powermenu.rasi"
host="$(hostname)"

format_uptime() {
  read -r secs _ </proc/uptime
  secs=${secs%.*}
  local days=$((secs / 86400)) hours=$(((secs % 86400) / 3600)) mins=$(((secs % 3600) / 60))
  local parts=()
  ((days > 0)) && parts+=("$days day$(((days != 1)) && printf s)")
  ((hours > 0)) && parts+=("$hours hour$(((hours != 1)) && printf s)")
  parts+=("$mins minute$(((mins != 1)) && printf s)")
  local out
  printf -v out '%s, ' "${parts[@]}"
  echo "${out%, }"
}
uptime_text="$(format_uptime)"

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
