
#! /usr/bin/env zsh

#print -l $path

exec rofi -modi "clipboard:greenclip print" \
	-show clipboard \
	-run-command '{cmd}' \
	-p "Presse-papier : "
