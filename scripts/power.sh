
#!/usr/bin/env bash

# ───────────────────────────────────────────────────────────────
#                      Theme Settings
# ───────────────────────────────────────────────────────────────
themedir=$CFGDIR/configs/rofi

# ───────────────────────────────────────────────────────────────
#                         Menu Options
# ───────────────────────────────────────────────────────────────
shutdown='󰐥'
reboot=''
lock=''
suspend=''
logout='󰍃'
    

# ───────────────────────────────────────────────────────────────
#                           User Info
# ───────────────────────────────────────────────────────────────
username=" $(whoami)"
messages=("See ya!" "Adiós, amigo!" "Catch you on the flip side!" "Powering down... but not for long!" "Peace out!")

# Pick a random message
sendoff="${messages[$((RANDOM % ${#messages[@]}))]}"

# ───────────────────────────────────────────────────────────────
#                           Rofi Cmd
# ───────────────────────────────────────────────────────────────
rofi_cmd() {
    rofi -dmenu \
        -p "$username" \
        -mesg "$sendoff" \
        -theme $themedir/power.rasi
}

# ───────────────────────────────────────────────────────────────
#                       Run Rofi Menu
# ───────────────────────────────────────────────────────────────
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# ───────────────────────────────────────────────────────────────
#                        Command Exec
# ───────────────────────────────────────────────────────────────
run_cmd() {
    if [[ $1 == '--shutdown' ]]; then
        systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
        systemctl reboot
    elif [[ $1 == '--suspend' ]]; then
        mpc -q pause
        amixer set Master mute
        systemctl suspend
    elif [[ $1 == '--logout' ]]; then
        pkill -KILL -u "$USER"
    fi
}

# ───────────────────────────────────────────────────────────────
#                           Execute Cmd
# ───────────────────────────────────────────────────────────────
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        betterlockscreen -l
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac

