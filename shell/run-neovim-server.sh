#! /usr/bin/env sh

psgrep='/bin/ps auxww | /bin/grep -v grep | /bin/grep --color=never'

$=psgrep nvim &> ~/log/psgrep.log && {
	echo 'neovim tourne déjà'
	echo
	return 0
}

exec nvim --listen ~/racine/run/socket/neovim --headless >> ~/log/neovim-server.log 2>&1
