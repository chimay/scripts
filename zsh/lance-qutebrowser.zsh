#! /usr/bin/env zsh

xdotool search --class qutebrowser windowactivate && exit 0

exec qutebrowser
