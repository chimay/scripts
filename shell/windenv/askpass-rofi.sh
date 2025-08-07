#!/usr/bin/env sh

# Credit: https://www.reddit.com/r/voidlinux/comments/kb4how/how_to_execute_suspend_and_hibernate_from_the/
#         https://www.reddit.com/r/qtools/comments/dwc02a/rofiquestion_how_to_hide_the_textbox/

exec rofi -dmenu -p 'Password ' -theme-str 'entry { enabled: false;}' 2> ~/log/rofi.err
