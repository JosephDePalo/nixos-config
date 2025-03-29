#!/bin/sh

WALL_LOC=$CFGDIR/Wallpaper

if [ ! -f $1 ]; then
	echo "File does not exist."
	exit
fi

rm $WALL_LOC 2> /dev/null
cp $1 $WALL_LOC

wal -c # Clear cache so old colors aren't used for same file name $WALL_LOC
wal -i $WALL_LOC

betterlockscreen -u $WALL_LOC > /dev/null &

sudo nixos-rebuild switch --flake $CFGDIR

pkill dunst
notify-send -t 3000 "Theme updated."
