#!/bin/zsh

if [ -n "$WAYLAND_DISPLAY" ]
then
	if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]
	then
		args=()
		for arg in "$@"; do
			[[ "$arg" == -t ]] && arg=--timeout
			args+=("$arg")
		done
		echo "$@"
		echo $=args
		echo "exec dms notify $=args"
		echo
		exec dms notify "$=args"
	fi
elif [ -n "$DISPLAY" ]
then
	exec notify-send "$@"
fi
