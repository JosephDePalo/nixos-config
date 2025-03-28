#!/usr/bin/env bash


dir=$(dirname $(realpath $0))

## Run
rofi \
    -show drun \
    -theme ${dir}/launcher.rasi
