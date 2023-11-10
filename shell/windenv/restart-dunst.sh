#!/usr/bin/env sh

pkill dunst
sleep 1
dunst >> ~/log/dunst.log 2>&1 &
