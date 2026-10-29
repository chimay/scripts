#!/usr/bin/env sh

# exit 0 = can suspend, non-zero = stay awake

code=0

# package manager {{{1

pgrep -x pacman >/dev/null && {
	echo pacmqn is running
	echo
	code=1
}

# ssh {{{1

pgrep -x ssh >/dev/null && {
	echo ssh connection is running
	echo
	code=1
}

# backup {{{1

pgrep -x borg >/dev/null && {
	echo borg is running
	echo
	code=1
}

pgrep -x restic >/dev/null && {
	echo restic is running
	echo
	code=1
}

# browser {{{1

pgrep -x vieb >/dev/null && {
	echo vieb is running
	echo
	code=1
}

pgrep -x zen-browser >/dev/null && {
	echo zen browser is running
	echo
	code=1
}

pgrep -x floorp >/dev/null && {
	echo floorp is running
	echo
	code=1
}

pgrep -x mullvad-browser >/dev/null && {
	echo mullvad browser is running
	echo
	code=1
}

pgrep -x helium >/dev/null && {
	echo helium is running
	echo
	code=1
}

pgrep -x waterfox >/dev/null && {
	echo waterfox is running
	echo
	code=1
}

# multimedia {{{1

pgrep -x vlc >/dev/null && {
	echo vlc is running
	echo
	code=1
}

pgrep -x freetube >/dev/null && {
	echo freetube is running
	echo
	code=1
}

mpc status | grep playing >/dev/null && {
	echo mpd is playing
	echo
	code=1
}

playerctl status | grep Playing >/dev/null && {
	echo multimedia is playing
	echo
	code=1
}

# exit {{{1

exit $code
