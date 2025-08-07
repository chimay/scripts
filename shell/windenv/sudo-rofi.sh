#!/usr/bin/env sh

# Credit: https://www.reddit.com/r/voidlinux/comments/kb4how/how_to_execute_suspend_and_hibernate_from_the/

export SUDO_ASKPASS=~/racine/shell/windenv/askpass-rofi.sh

# echo $SUDO_ASKPASS
# echo

sudo -A "$@"
