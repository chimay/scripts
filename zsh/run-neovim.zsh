#! /usr/bin/env zsh

xdotool search --class nvim-qt windowactivate && exit 0

nvim-qt \
	--nvim nvim \
	--geometry 1200x700 \
	-- \
	-u ~/racine/config/edit/neovim/init.vim \
	"$@"
