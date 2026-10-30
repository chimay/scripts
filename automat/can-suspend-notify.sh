#!/usr/bin/env sh

can_suspend=$(can-suspend.sh)
code=$?

[ $code -eq 0 ] || {
	notify-send "Suspend is blocked" "$can_suspend"
}

exit $code
