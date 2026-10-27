#!/usr/bin/env sh

export PATH=$HOME/.local/share/mise/installs/herdr/latest:$PATH

herdr="kitty --single-instance herdr"

session=$( \
	herdr session list --json | jq -r '.. | objects | .name? // empty' | \
	rofi -dmenu -i -p "herdr session " \
)

[ -z $session ] && exec $herdr

$herdr session attach $session
