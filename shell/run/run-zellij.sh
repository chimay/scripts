#!/usr/bin/env sh

zellij="kitty --single-instance zellij"

if ! pgrep -ax zellij
then
	$zellij
	[ $? -eq 0 ] && exit 0
fi

session=$(zellij list-sessions --short | rofi -dmenu -i -p "zellij session ")

[ -z $session ] && exit 0

$zellij attach $session
