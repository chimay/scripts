#! /usr/bin/env sh

psgrep='/bin/ps auxww | /bin/grep -v grep | /bin/grep --color=never'

$=psgrep kak &> ~/log/psgrep.log && {
	echo 'kakoune tourne déjà'
	echo
	return 0
}

exec kak -d -s kak-server -E 'cd ~/racine/public/python-misc' >> ~/log/kak-server.log 2>&1
