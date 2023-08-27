#! /usr/bin/env sh

pgrep 'emacs.*daemon' > ~/log/psgrep.log 2>&1 && {
	echo 'emacs tourne déjà'
	echo
	exit 0
}

exec emacs --daemon
