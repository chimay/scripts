#! /usr/bin/env sh

psgrep='/bin/ps auxww | /bin/grep -v grep | /bin/grep --color=never'

$=psgrep 'emacs.*daemon' &> ~/log/psgrep.log && {
	echo 'emacs tourne déjà'
	echo
	return 0
}

exec emacs --daemon
