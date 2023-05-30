#! /usr/bin/env sh

application=$1
shift

xdotool search --name "$application" windowactivate && exit 0

exec kitty --name "$application" "$application" "$@" >> ~/log/kitty-"$application".log 2>&1
