#!/usr/bin/env sh

# vim: set filetype=zsh:

pkill dunst
sleep 1
dunst >> ~/log/dunst.log 2>&1 &
