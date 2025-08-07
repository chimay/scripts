#!/usr/bin/env sh

# Credit: https://www.reddit.com/r/voidlinux/comments/kb4how/how_to_execute_suspend_and_hibernate_from_the/
#         https://www.reddit.com/r/qtools/comments/dwc02a/rofiquestion_how_to_hide_the_textbox/

# See also ~/racine/config/windenv/rofi/themes/invisible.rasi

exec rofi -dmenu -p 'Password ' -theme invisible 2> ~/log/rofi.err
