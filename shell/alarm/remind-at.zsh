#! /usr/bin/env zsh

when=($1)
shift
voice=${1:-$HOME/audio/bell/notification/generique.ogg}
shift
notification="'${*:-Générique}'"

echo When : $when
echo Voice : $voice
echo Notification : $notification
echo

cat <<- FIN | at $when 2> ~/log/at.err
	bell.zsh $voice
	notify-send 'Remind from at' $notification
FIN

echo

atq
