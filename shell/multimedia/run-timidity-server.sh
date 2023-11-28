#!/usr/bin/env sh

pgrep -af timidity > /dev/null && {
	echo Timidity is already running.
	exit 0
}

echo timidity -B1,8 -iA
timidity -B1,8 -iA &
