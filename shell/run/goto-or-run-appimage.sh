#! /usr/bin/env sh

application=$1
shift

echo application : "$application"
echo

xdotool search --class "$application" windowactivate && exit 0

"$application" "$@" >> ~/log/"$application".log 2>&1

sleep 5

echo "unmount-appimage.sh $application"
echo
unmount-appimage.sh "$application"
