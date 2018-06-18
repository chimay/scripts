#! /usr/bin/env zsh

xdotool windowactivate $(xdotool search --class Gvim | tail -n 1) && exit 0

exec vim -c "cd ~/racine/plain" -g "$@"
