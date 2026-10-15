#!/usr/bin/env zsh

local cache=(~/.cache/ueberzugpp/*)
(( $#cache > 0 )) && trash-put $=cache

if [ -n "$WAYLAND_DISPLAY" ]
then
	# -- use ueberzugpp kitty backend to avoid flicker loop in wayland
	kitty --single-instance vifmrun-fix
elif [ -n "$DISPLAY" ]
then
	kitty --single-instance vifmrun
fi

# cd ~/racine/config/fileman/vifm
# vifm-clean-matchers.sh vifminfo.json
# cd sessions
# vifm-clean-matchers.sh *.json
