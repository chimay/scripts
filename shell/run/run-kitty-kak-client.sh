#! /usr/bin/env sh

xdotool search --name kak windowactivate && exit 0

exec kitty --name kak kak -c kak-server
