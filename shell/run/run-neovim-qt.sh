#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

# ---- we need neovim-remote to equalize windows
which nvr || {
	echo Please install neovim-remote with pip first
	exit 0
}

nvim-qt -- "$@" >> ~/log/nvim-qt.log 2>> ~/log/nvim-qt.err

sleep 1
nvr --remote-expr 'library#equal_windows()'
