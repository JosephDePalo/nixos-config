#!/bin/sh

# Apply wallpaper using wal
wal -i ~/Configs/Wallpaper

# Run status bar
polybar --config=~/Configs/configs/polybar/config.ini -r laptop &

# Run automount daemon
udiskie &

# Run lockscreen
xss-lock -- betterlockscreen -l &
