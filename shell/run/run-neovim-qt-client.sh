#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

#	--no-ext-tabline \
#	--geometry 1200x700 \

# exec nvim-qt \
# 	--nofork \
# 	--server ~/racine/run/socket/neovim \
# 	-- \
# 	"$@" >> ~/log/neovim-qt-client.log 2>&1

nvim-qt \
	--server ~/racine/run/socket/neovim \
	-- \
	"$@" >> ~/log/neovim-qt-client.log 2>&1

which nvr || exit 0
sleep 1
nvr --remote-send '<cmd>call library#equal_windows()<cr>'
