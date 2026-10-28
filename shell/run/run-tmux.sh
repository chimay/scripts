#!/usr/bin/env sh

tmux="kitty --single-instance tmux"

if ! pgrep -ax tmux
then
	systemctl --user start tmux
	[ $? -eq 0 ] || exit 0
fi

session=$( \
	tmux list-sessions -F '#{session_name}' |
	rofi -dmenu -i -p "tmux session " \
)

[ -z $session ] && exec $tmux

$tmux attach -t $session
