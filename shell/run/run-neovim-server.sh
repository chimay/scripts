#! /usr/bin/env sh

pgrep nvim > ~/log/psgrep.log 2>&1 && {
	echo 'neovim tourne déjà'
	echo
	exit 0
}

if ! [ -z "$(ls -A ~/racine/varia/autosave/neovim)" ]
then
	echo -n "There are autosave files. Continue ?"
	read $answer
	[ $answer = y ] || [ $answer = yes ] || exit 0
fi

exec nvim --listen ~/racine/run/socket/neovim --headless >> ~/log/neovim-server.log 2>&1
