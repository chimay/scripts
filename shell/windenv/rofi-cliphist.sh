#!/usr/bin/env sh

cliphist list | rofi -dmenu | cliphist decode | wl-copy
