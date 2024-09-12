#!/usr/bin/env sh

# credit: https://www.reddit.com/r/archlinux/comments/50ft9r/any_tips_on_analyzing_disk_space_usage_and_how_do/

expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqe | sort) <(pacman -Qqg base base-devel | sort)) | sort -n
