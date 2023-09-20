#!/usr/bin/env zsh

delai_court=${1:-5}
delai_long=${2:-700}

while true
do
	autre=0

	pulsemixer --list-sinks | grep 'Name: Chromium' &>/dev/null         && autre=1
	pulsemixer --list-sinks | grep 'Name: qutebrowser' &>/dev/null      && autre=1
	pulsemixer --list-sinks | grep 'Name: qutebrowser' &>/dev/null      && autre=1
	pulsemixer --list-sinks | grep 'Name: Falkon' &>/dev/null      && autre=1
	pulsemixer --list-sinks | grep 'Name: VLC media player' &>/dev/null && autre=1
	pulsemixer --list-sinks | grep 'Name: AudioIPC Server' &>/dev/null  && autre=1

	echo "== $(date +%H:%M:%S) =="
	echo
	echo Autre : $autre
	echo

	if (( autre == 0 ))
	then
		mpc play
		echo
		echo "sleep $delai_court"
		echo
		sleep $delai_court
	else
		mpc pause
		echo
		echo "sleep $delai_long"
		echo
		sleep $delai_long
	fi

done
