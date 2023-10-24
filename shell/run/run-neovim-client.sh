#! /usr/bin/env sh

#exec nvim --server ~/racine/run/socket/neovim --remote-ui "$@"

which nvr && ( sleep 1 ; nvr --remote-send '<cmd>call biblio#equal_windows()<cr>' ) &

nvim --server ~/racine/run/socket/neovim --remote-ui "$@"
