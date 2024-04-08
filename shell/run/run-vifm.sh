#!/usr/bin/env sh

#xterm -e vifmrun
urxvtc -e vifmrun
#kitty vifmrun

cd ~/racine/config/fileman/vifm
vifm-clean-matchers.sh vifminfo.json
cd sessions
vifm-clean-matchers.sh *.json
