#!/usr/bin/env sh

echo Autowake : $(date +"%H:%M %A %d %B %Y")
echo

brightnessctl set 90%

pkill -10 -f remind-server
