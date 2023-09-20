#!/usr/bin/env sh

# vifmrun wrapper : to be able to preview images
kitty vifmrun

cd ~/racine/config/fileman/vifm
vifm-clean-matchers.sh vifminfo.json
cd sessions
vifm-clean-matchers.sh *.json
