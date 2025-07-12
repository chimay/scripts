#! /usr/bin/env sh

pgrep 'emacs.*daemon' > ~/log/psgrep.log 2>&1 && {
	echo 'emacs is already running'
	echo
	exit 0
}

exec emacs --daemon >> ~/log/emacs-server.log 2>&1
