#! /usr/bin/env sh

pgrep nvim > ~/log/psgrep.log 2>&1 && {
	echo 'neovim tourne déjà'
	echo
	exit 0
}

exec nvim --listen ~/racine/run/socket/neovim --headless >> ~/log/neovim-server.log 2>&1
