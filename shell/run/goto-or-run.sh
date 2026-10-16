#! /usr/bin/env sh

application=$1
shift

if [ -n "$WAYLAND_DISPLAY" ]
then
	address=$(hyprctl clients -j | \
		jq -r --arg app "$application" '.[] | select(.class == $app) |  .address' | \
		head -n1 \
	)
	if [[ -n $address ]]; then
		hyprctl dispatch focuswindow "address:$address"
		exit 0
	fi
elif [ -n "$DISPLAY" ]
	xdotool search --class "$application" windowactivate && exit 0
then
fi

exec "$application" "$@" >> ~/log/"$application".log 2>&1
