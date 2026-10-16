#! /usr/bin/env sh

application=$1
shift

if [ -n "$WAYLAND_DISPLAY" ]
then
	echo
elif [ -n "$DISPLAY" ]
then
	xdotool search --class "$application" windowactivate && exit 0
fi

exec "$application" "$@" >> ~/log/"$application".log 2>&1
