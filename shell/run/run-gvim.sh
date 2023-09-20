#! /usr/bin/env sh

xdotool windowactivate "$(xdotool search --class Gvim | tail -n 1)" && exit 0

exec gvim "$@" >> ~/log/gvim.log 2>&1
