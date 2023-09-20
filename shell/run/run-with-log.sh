#!/usr/bin/env sh

application=$1

xdotool search --class "$application" windowactivate && exit 0

exec "$application" > ~/log/"$application".log 2>&1
