#!/bin/zsh

# Credit:
# https://www.reddit.com/r/bspwm/comments/85hr4c/making_a_scratchpaddropdown_terminal_in_bspwm/

id=$(xdo id -N kitty -n dropdown)

echo id = $id
echo

if [ -z "$id" ]; then
  kitty --name dropdown -e zsh
else
  action='hide';
  if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
    action='show';
  fi
  xdo $action -N kitty -n dropdown
fi
