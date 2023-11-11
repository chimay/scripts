#!/usr/bin/env sh

exec >> ~/log/notify-sound.sh
exec 2>&1

appname=$1
summary=$2
body=$3
icon=$4
urgency=$5

echo "appname : $appname"
echo "summary : $summary"
echo "body    : $body"
echo "icon    : $icon"
echo "urgency : $urgency"
echo

[ "$summary" = Reminder ] || \
	[ "$summary" = "New mail" ] || \
	exit 0

mpvsocket=~/racine/shell/multimedia/mpv-socket.bash
$mpvsocket add ~/audio/bell/ding/aether.ogg

if [ "$HOST" = taijitu ]
then
	$mpvsocket volume 96
elif [ "$HOST" = shari ]
then
	$mpvsocket volume 72
else
	$mpvsocket volume 84
fi

echo
echo "------------------------------"
echo
