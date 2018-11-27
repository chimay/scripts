#! /usr/bin/env zsh

temps=($1)
shift
notification="'${*:-rappel}'"

echo Temps : $temps
echo Notification : $notification
echo

cat <<- FIN | at $temps 2> ~/log/at.err
	sonnerie.zsh $HOME/audio/Sonnerie/notification/generique.ogg
	notify-send -u critical $notification
FIN

echo

atq
