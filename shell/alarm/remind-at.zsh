#! /usr/bin/env zsh

temps=($1)
shift
notification="'${*:-Générique}'"

echo Temps : $temps
echo Notification : $notification
echo

cat <<- FIN | at $temps 2> ~/log/at.err
	bell.zsh $HOME/audio/bell/notification/generique.ogg
	notify-send Rappel $notification
FIN

echo

atq
