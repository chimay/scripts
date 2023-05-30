#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

#	--no-ext-tabline \
#	--geometry 1200x700 \

exec nvim-qt \
	--nofork \
	--server ~/racine/run/socket/neovim \
	-- \
	"$@" >> ~/log/neovim-qt-client.log 2>&1
