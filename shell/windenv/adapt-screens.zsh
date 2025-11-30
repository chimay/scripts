#!/usr/bin/env zsh

if [ $HOST = taijitu ]
then
	connected=$(xrandr --query | grep -w connected | grep 'HDMI-1')
	hdmi=$?
else
	connected=$(xrandr --query | grep -w connected | grep 'HDMI1')
	hdmi=$?
fi

echo connected hdmi : $connected
echo hdmi : $hdmi
echo

if [[ $hdmi -eq 0 ]]
then
	echo "HDMI connected"
	# -- xrandr
	if [ $HOST = taijitu ]
	then
		xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --off
	else
		xrandr --output LVDS1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --off
	fi
	# -- bspwm
	#bspc monitor LVDS1 -n 0 -d term edit browser office artisan entertain misc
	#bspc monitor HDMI1 -n 1 -d movie sport game
	# -- polybar
	polybar.zsh
	echo "---" | tee -a ~/log/polybar/superieur_hdmi.log ~/log/polybar/inferieur_hdmi.log
	polybar superieur_hdmi >>~/log/polybar/superieur_hdmi.log 2>&1 &
	polybar inferieur_hdmi >>~/log/polybar/inferieur_hdmi.log 2>&1 &
	echo "Bars launched..."
else
	echo "HDMI disconnected"
	#bspc monitor eDP-1 -d term edit browser office artisan entertain misc
	polybar.zsh
fi
