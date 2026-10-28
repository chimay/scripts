#!/usr/bin/env sh

zellij="kitty --single-instance zellij"

session=$(zellij list-sessions --short | rofi -dmenu -i -p "zellij session ")

[ -z $session ] && exec $zellij

$zellij attach $session
