#!/bin/sh

# Apply wallpaper using wal
wal -i ~/.wallpaper

# Run status bar
polybar --config=~/Configs/polybar/config.ini &

# Run automount daemon
udiskie &

# Run lockscreen
xss-lock -- betterlockscreen -l &
