#!/usr/bin/env zsh

# vim: set filetype=zsh:

pkill picom
sleep 1
picom &>>! ~/log/picom.log 2>&1 &
