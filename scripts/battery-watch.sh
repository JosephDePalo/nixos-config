#!/usr/bin/env bash

THRESHOLD=20

while true; do
  BAT=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%')

  STATE=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}')

  if [ "$STATE" != "charging" ] && [ "$BAT" -le "$THRESHOLD" ]; then
    notify-send "Low Battery" "Battery at ${BAT}%"
    sleep 300
  fi

  sleep 60
done
