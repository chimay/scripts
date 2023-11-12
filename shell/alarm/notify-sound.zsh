#!/usr/bin/env zsh

exec >> ~/log/notify-sound.log
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

[ "$urgency" = CRITICAL ] || \
[ "$summary" = Reminder ] || \
	[ "$summary" = "New mail" ] || \
	[[ $summary = *mentioned*you* ]] || \
	exit 0

mpvsocket=~/racine/shell/multimedia/mpv-socket.bash

if [ "$urgency" = CRITICAL ]
then
	soundfile=~/audio/bell/ding/bol-tibetain.ogg
else
	soundfile=~/audio/bell/ding/aether.ogg
fi

$mpvsocket add $soundfile

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
