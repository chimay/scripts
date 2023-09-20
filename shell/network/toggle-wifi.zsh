#!/usr/bin/env zsh

if which wifi
then
	wifi toggle
	notify-send "$(wifi)"
elif which nmcli
then
	if [[ $(nmcli radio wifi) = *disabled* ]]
	then
		nmcli radio wifi on
		notify-send "nmcli : wifi on"
	else
		nmcli radio wifi off
		notify-send "nmcli : wifi off"
	fi
elif which rfkill
then
	rfkill toggle wlan
	notify-send "$(rfkill)"
else
	echo No command found to toggle wifi.
fi
