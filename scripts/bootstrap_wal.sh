#!/bin/sh

rootdir=$(realpath $0 | xargs dirname)/..
wallpaper=$rootdir/Wallpaper

cp -r $rootdir/configs/wal/templates ~/.config/wal/
mkdir -p $rootdir/.cache/wal 2> /dev/null
wal -i $wallpaper
cp -r ~/.cache/wal $rootdir/.cache/
