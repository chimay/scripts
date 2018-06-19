#!/usr/bin/env /bin/zsh

temps=${1:-15}

while true
do
	autre=0

	pulsemixer --list-sinks | grep 'Name: Chromium' &>/dev/null && autre=1
	pulsemixer --list-sinks | grep 'Name: VLC media player' &>/dev/null && autre=1
	pulsemixer --list-sinks | grep 'Name: AudioIPC Server' &>/dev/null && autre=1

	echo Autre : $autre
	echo

	(( autre == 0 )) && mpc play
	(( autre == 1 )) && mpc pause

	echo
	echo "sleep $temps"
	echo

	sleep $temps
done
