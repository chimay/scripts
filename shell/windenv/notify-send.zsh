#!/bin/zsh

echo WAYLAND DISPLAY : $WAYLAND_DISPLAY
echo HYPRLAND INSTANCE : $HYPRLAND_INSTANCE_SIGNATURE
echo

if [ -n "$WAYLAND_DISPLAY" ]
then
	if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]
	then
		args=()
		for arg in "$@"; do
			[[ "$arg" == -t ]] && arg=--timeout
			args+=("$arg")
		done
		echo "exec dms notify $=args"
		echo
		exec dms notify "$=args"
	else
		echo NOT IMPLEMENTED
	fi
elif [ -n "$DISPLAY" ]
then
	exec notify-send "$@"
fi
