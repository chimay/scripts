#! /usr/bin/env zsh

xdotool search --class nvim-qt windowactivate && exit 0

#SERVEUR=/tmp/neovim-serveur/0

SERVEUR=`echo /tmp/nvim*(/om[1])`/0

echo $SERVEUR
echo

exec /usr/local/bin/nvim-qt \
	--server $SERVEUR
	--geometry 1200x700 \
	-- \
	"$@"
