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

"$application" "$@" >> ~/log/"$application".log 2>&1

sleep 5

echo "unmount-appimage.sh $application"
echo
unmount-appimage.sh "$application"
