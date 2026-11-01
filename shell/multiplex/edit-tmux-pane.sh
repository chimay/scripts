#!/usr/bin/env sh

file=$(mktemp).sh

tmux capture-pane -pS -32768 > "$file"
tmux new-window -n edit-tmux-pane "neovim-lite.sh '+ normal G 0' $file"
