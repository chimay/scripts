#!/usr/bin/env zsh

# vim: set fdm=marker :

# Chemins d’accès {{{1

source ~/racine/config/cmdline/zsh/zprofile

# Variables {{{1

HOST=`hostname -s`

# Clean up {{{1

pkill -f udiskie &
pkill -f alarm-battery.zsh &
pkill -f alarm-memory.zsh &
pkill -f alarm-sensor.zsh &
pkill -f nm-applet &
pkill -f protonvpn-app &
pkill -f blueman-applet &
pkill -f wallpaper.zsh &
pkill -f gammastep &
pkill -f swhks &
pkexec pkill -f swhkd &
pkill -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
pkill -f dunst &
pkill -f log-notifications.bash &
pkill -f remind-server.zsh &
pkill -f remind &
pkill -f mpd &
pkill -f timidity &
pkill -f clock.zsh &
pkill -f aria2c &
pkill -f transmission-daemon &
pkill -f syncthing.sh &
dad -d ~/racine/gate/download stop &
pkill -f element-desktop &
pkill -f kdeconnect &

if [ $HOST = mandala ]
then
	# ...
fi
