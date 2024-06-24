#!/usr/bin/env zsh

# Credit:
# https://www.reddit.com/r/bspwm/comments/85hr4c/making_a_scratchpaddropdown_terminal_in_bspwm/

iden=$(xdo id -N URxvt -n calculator)

echo iden = $iden
echo

if [ -z "$iden" ]; then
	urxvtc -name calculator -e calc
else
	action='hide';
	if [[ $(xprop -id $iden | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
		action='show';
	fi
	xdo $action -N URxvt -n calculator
fi
