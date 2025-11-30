#!/usr/bin/env zsh

if [ $HOST = taijitu ]
then
	xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off
else
	xrandr --output LVDS1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output DP1 --off
fi
