#! /usr/bin/env zsh

xdotool windowactivate $(xdotool search --class Gvim | tail -n 1) && exit 0

exec vim -g "$@"

# Plus nécessaire avec wheel

#exec vim -c "cd ~/racine/plain" -g "$@"

#vim -c "cd ~/racine/plain" -g "$@" && exit 0
