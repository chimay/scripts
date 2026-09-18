#!/usr/bin/env zsh

local cache=(~/.cache/ueberzugpp/*)
(( $#cache > 0 )) && trash-put $=cache

#xterm -e vifmrun
#urxvtc -e vifmrun
kitty --single-instance vifmrun

cd ~/racine/config/fileman/vifm
vifm-clean-matchers.sh vifminfo.json
cd sessions
vifm-clean-matchers.sh *.json
