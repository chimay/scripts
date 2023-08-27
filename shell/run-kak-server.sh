#! /usr/bin/env sh

psgrep='/bin/ps auxww | /bin/grep -v grep | /bin/grep --color=never'

$psgrep kak >> ~/log/psgrep.log 2>&1 && {
	echo 'kakoune tourne déjà'
	echo
	return 0
}

#[ -S /run/user/"$(id -u)"/kakoune/kak-server ] && rm -f /run/user/"$(id -u)"/kakoune/kak-server

exec kak -d -s kak-server -E 'cd ~/racine/public/python-misc' >> ~/log/kak-server.log 2>&1
