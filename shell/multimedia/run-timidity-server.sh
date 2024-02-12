#!/usr/bin/env sh

if pgrep -af timidity | grep -v "$0" > /dev/null
then
	echo timidity is already running.
	exit 0
fi

echo "timidity -B1,8 -iA > ~/log/timidity-server.log 2>&1 &"
timidity -B1,8 -iA > ~/log/timidity-server.log 2>&1 &
