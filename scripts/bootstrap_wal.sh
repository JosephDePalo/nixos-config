#!/bin/sh
mkdir -p $CFGDIR/.cache/wal 2> /dev/null
wal -i $CFGDIR/Wallpaper
cp -r ~/.cache/wal $CFGDIR/.cache/
