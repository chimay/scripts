#!/usr/bin/env zsh

# vim: set filetype=zsh:

while ! [ -S /run/user/$(id -u)/mpv-socket ]
do
	echo "Accueil : waiting"
	echo
	sleep 5
done

mpv-socket.bash add $HOME/audio/bell/notification/accueil.ogg
mpv-socket.bash volume 100
