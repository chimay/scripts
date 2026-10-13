#!/usr/bin/env zsh

# vim: set fdm=marker :

# paths {{{1

source ~/racine/config/cmdline/zsh/zprofile

# variables {{{1

HOST=`hostname -s`

# backups {{{1

cd ~/run/wall

command cp -f wallpaper.status wallpaper.status.bak

cd ~/run/clock

command cp -f clock.status clock.status.bak

# clean up {{{1

dad -d ~/racine/gate/download stop &
pkill -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
pkill -f alarm-battery.zsh &
pkill -f alarm-memory.zsh &
pkill -f alarm-sensor.zsh &
pkill -f aria2c &
pkill -f awww-daemon &
pkill -f blueman-applet &
pkill -f clock.zsh &
pkill -f dunst &
pkill -f element-desktop &
pkill -f gammastep &
pkill -f kdeconnect &
pkill -f log-notifications.bash &
pkill -f mako &
pkill -f mpd &
pkill -f nm-applet &
pkill -f protonvpn-app &
pkill -f remind &
pkill -f remind-server.zsh &
pkill -f swaybg &
pkill -f syncthing.sh &
pkill -f timidity &
pkill -f transmission-daemon &
pkill -f udiskie &
pkill -f urxvtd &
pkill -f wallpaper.zsh &
pkill -f wl-paste &
pkill -f xremap &

# host specific {{{1

if [ $HOST = mandala ]
then
	# ...
fi

# sleep {{{1

sleep 2
