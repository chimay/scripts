#! /usr/bin/env zsh

temps=($1)
shift
notification="'${*:-rappel}'"

echo Temps : $temps
echo Notification : $notification
echo

code=(sonnerie.zsh $HOME/audio/Sonnerie/notification/generique.ogg n=$notification)

echo $code | at $temps 2> ~/log/at.err

echo

atq
