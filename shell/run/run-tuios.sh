#!/usr/bin/env sh

export PATH=$HOME/.local/share/mise/installs/aqua-gaurav-gosain-tuios/latest:$PATH

tuios="kitty --single-instance tuios"

if ! pgrep -ax tuios
then
	exec $tuios
fi

session=$( \
	tuios ls --json | \
	jq -r '.[] | "\(.name)"' |
	rofi -dmenu -i -p 'tuios session ' \
)

$tuios attach $session
