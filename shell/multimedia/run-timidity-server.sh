#!/usr/bin/env sh

if pgrep -af timidity | grep -v "$0" > /dev/null
then
	echo Timidity is already running.
	exit 0
fi

echo timidity -B1,8 -iA
timidity -B1,8 -iA &
