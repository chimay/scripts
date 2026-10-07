#!/usr/bin/env sh

# source the script for check may-start to work

# does not handle the session : brightnessctl not permitted

if uwsm check may-start -v 2 3 4 5 6 && uwsm select
then
	exec uwsm start default
fi
