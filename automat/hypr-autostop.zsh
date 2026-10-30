#!/usr/bin/env zsh

# vim: set fdm=marker :

# paths {{{1

source ~/racine/config/cmdline/zsh/zprofile

# variables {{{1

HOST=`hostname -s`

# clean up {{{1

systemctl --user stop hyprpolkitagent

pgrep -f awww && awww kill &
pgrep -f dad && dad -d ~/racine/gate/download stop &
pgrep -f copyq && copyq exit

pgrep -f mpd-mpris && pkill -f mpd-mpris &

pgrep -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 && \
	pkill -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

pgrep -f alarm-battery.zsh && pkill -f alarm-battery.zsh &
pgrep -f alarm-memory.zsh && pkill -f alarm-memory.zsh &
pgrep -f alarm-sensor.zsh && pkill -f alarm-sensor.zsh &
pgrep -f aria2c && pkill -f aria2c &
pgrep -f blueman-applet && pkill -f blueman-applet &
pgrep -f clock.zsh && pkill -f clock.zsh &
pgrep -f dunst && pkill -f dunst &
pgrep -f element-desktop && pkill -f element-desktop &
pgrep -f gammastep && pkill -f gammastep &
pgrep -f gnome-keyring-daemon && pkill -f gnome-keyring-daemon &
pgrep -f kdeconnect && pkill -f kdeconnect &
pgrep -f log-notifications.bash && pkill -f log-notifications.bash &
pgrep -f mako && pkill -f mako &
pgrep -f mpd && pkill -f mpd &
pgrep -f nm-applet && pkill -f nm-applet &
pgrep -f protonvpn-app && pkill -f protonvpn-app &
pgrep -f remind && pkill -f remind &
pgrep -f remind-server.zsh && pkill -f remind-server.zsh &
pgrep -f swaybg && pkill -f swaybg &
pgrep -f syncthing.sh && pkill -f syncthing.sh &
pgrep -f timidity && pkill -f timidity &
pgrep -f transmission-daemon && pkill -f transmission-daemon &
pgrep -f udiskie && pkill -f udiskie &
pgrep -f urxvtd && pkill -f urxvtd &
pgrep -f wallpaper.zsh && pkill -f wallpaper.zsh &
pgrep -f wl-paste && pkill -f wl-paste &
pgrep -f xremap && pkill -f xremap &

# host specific {{{1

if [ $HOST = mandala ]
then
	# ...
fi

# sleep {{{1

sleep 2
