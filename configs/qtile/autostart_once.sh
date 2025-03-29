#!/bin/sh

# Apply wallpaper using wal
wal -i $CFGDIR/Wallpaper

# Run status bar
if [ $(hostname) == "jdnixlt" ]; then
  polybar --config=$CFGDIR/configs/polybar/config.ini -r laptop &
else
  polybar --config=$CFGDIR/configs/polybar/config.ini -r desktop &
fi

# Run automount daemon
udiskie &

# Run lockscreen
xss-lock -- betterlockscreen -l &
