#!/usr/bin/env bash


themedir=$CFGDIR/configs/rofi

## Run
rofi \
    -show drun \
    -theme $themedir/launcher.rasi
