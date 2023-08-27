#! /usr/bin/env zsh

xdotool search --class nvim-qt windowactivate && exit 0

exec nvim-qt "$@" >> ~/log/nvim-qt.log 2>&1
