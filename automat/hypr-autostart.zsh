#!/usr/bin/env zsh

# vim: set fdm=marker :

# On freebsd :
# - disable remind-server : cpu 100%
# - disable alarm-memory : not reliable

# path {{{1

source ~/racine/config/cmdline/zsh/zprofile

# variables {{{1

HOST=$(hostname -s) || HOST=$(hostname)

UID=$(id -u)

rundir=$XDG_RUNTIME_DIR

[ -z $rundir ] && rundir=/run/user/$UID

if [ -d $rundir ]
then
	mpv_socket=$rundir/mpv-socket
else
	mpv_socket=~/run/socket/mpv
fi

# aliases {{{1

alias psgrep='ps auxww | grep -v grep | grep --color=never'

# restore backups {{{1

# cd ~/run/wall

# command cp -f wallpaper.status.bak wallpaper.status

# cd ~/run/clock

# command cp -f clock.status.bak clock.status

# hardware {{{1

# services {{{1

# screen {{{2

brightnessctl set 100%

hypridle >>! ~/log/hypridle.log 2>&1 &

# ---- redshift controlled by dms ipc call night toggle

# Keyboard {{{2

# ---- conflicts with super+ctrl, super+F<1-12> kays

xremap ~/racine/config/windenv/xremap/modifiers.yml &

# storage {{{2

# udiskie --no-automount --notify --tray >>! ~/log/udiskie.log 2>&1 &

# battery {{{2

psgrep alarm-battery.zsh || alarm-battery.zsh 30 15 5 60 >>! ~/log/alarm-battery.log 2>&1 &

# mémory {{{2

psgrep alarm-memory.zsh || alarm-memory.zsh 7 >>! ~/log/alarm-memory.log 2>&1 &

# temperature {{{2

if [ $HOST = universe ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +90 ++100 -30 >>! ~/log/alarm-sensor.log 2>&1 &
elif [ $HOST = galaxy ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +80 ++90 -30 >>! ~/log/alarm-sensor.log 2>&1 &
elif [ $HOST = mandala ]
then
	psgrep alarm-sensor.zsh || alarm-sensor.zsh +80 ++85 -30 >>! ~/log/alarm-sensor.log 2>&1 &
fi

# D-Bus : message bus system {{{2

if [ $HOST = mandala ]
then
	dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# identification {{{2

systemctl --user start hyprpolkitagent

# psgrep polkit-gnome-authentication-agent || \
# 	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# psgrep gnome-keyring-daemon || \
# 	eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

# network {{{2

psgrep nm-applet || nm-applet &

# if [ $HOST = galaxy ]
# then
# 	psgrep protonvpn-app || protonvpn-app >>! ~/log/protonvpn-app.log 2>&1 &
# elif [ $HOST = taijitu ]
# then
# 	psgrep protonvpn-app || protonvpn-app >>! ~/log/protonvpn-app.log 2>&1 &
# elif [ $HOST = mandala ]
# then
# 	psgrep protonvpn-app || protonvpn-app >>! ~/log/protonvpn-app.log 2>&1 &
# fi

# bluetooth {{{2

psgrep blueman-applet || blueman-applet &

# terminal {{{2

psgrep urxvtd || urxvtd -q -o -f

# clipboard {{{2

psgrep wl-paste || {
	wl-paste --type text --watch cliphist store &
	#wl-paste --type image --watch cliphist store
}

# notifications {{{2

# ---- mako history is not persistent

#mako &

# ---- dunst est lancé par
# ---- ~/.local/share/dbus-1/services/org.freedesktop.Notifications.service

#log-notifications.bash ~/log/notifications.log &

# reminder {{{2

psgrep remind-server || {
	remind-server.zsh ~/racine/config/organizer/remind/reminders 5 >>! ~/log/remind.log 2>&1 &
}

# music {{{2

[ -S $mpv_socket ] || rm -f $mpv_socket

psgrep 'mpv --idle --input-ipc-server' || \
	mpv \
	--idle \
	--input-ipc-server=$mpv_socket \
	>>! ~/log/mpv-socket.log 2>&1 &!

psgrep mpd || { rm -f ~/racine/run/mpd/pid ; mpd ~/racine/config/multimedia/mpd.conf }

psgrep timidity || run-timidity-server.sh

# clock {{{2

psgrep clock || clock.zsh ~/run/clock/clock.status >>! ~/log/clock.log 2>&1 &

# Synchronization {{{2

psgrep syncthing || syncthing.sh &

# downloads {{{2

# dad runs :
# aria2c --daemon --enable-rpc --continue --dir ~/racine/gate/download --input-file ~/.local/share/diana.session --save-session ~/.local/share/diana.session

psgrep aria2c || {
	dad -d ~/racine/gate/download start
}

psgrep transmission || transmission-daemon

# social {{{2

if [ $HOST = none ]
then
	#hexchat --minimize=2 -a &
	#run-quassel.sh &
	run-element.sh &
fi

#  Téléphone {{{2

psgrep kdeconnect || kdeconnect-indicator &

# desktop environment {{{1

# wallpaper {{{2

psgrep awww-daemon || awww-daemon &

psgrep wallpaper.zsh || wallpaper.zsh ~/run/wall/wallpaper.status >>! ~/log/wallpaper.log 2>&1 &

# gui shell : bar, dock, systray, login, power {{{2

dms run

#noctalia &

# Message d’accueil {{{1

welcome.zsh >>! ~/log/accueil.log 2>&1 &
