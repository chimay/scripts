#!/usr/bin/env zsh

#export PATH=$PATH:~/racine/shell/run

hl() {
    hyprctl "$@"
}

tmux_sessions=( $(tmux list-sessions -F "#{session_name}") )

(( $#tmux_sessions == 1 )) && {
	echo Only one tmux session : renaming it to principal
	echo
	tmux rename-session principal

# 	echo Creating tmux session simple
# 	echo
# 	tmux new-session -t simple -d

	echo Creating tmux session ssh
	echo
	tmux new-session -t ssh -d
}

echo Launching neovim server
echo
run-neovim-server.sh &
#sleep 1

echo Going to first workspace
echo
hl dispatch 'hl.dsp.focus({ workspace = "1" })'
sleep 1

echo Launching zellij
echo
kitty --single-instance zellij attach principal &
sleep 1

echo Launching tmux
echo
kitty --single-instance tmux attach-session -t principal &
sleep 1

echo Going to third workspace
echo
hl dispatch 'hl.dsp.focus({ workspace = "3" })'
sleep 1

echo Launching herdr
echo
kitty --single-instance herdr &

echo Launching neovim client
echo
run-neovim-qt-client.sh &
