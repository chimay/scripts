#!/usr/bin/env zsh

#export PATH=$PATH:~/racine/shell/run

hc() {
    herbstclient "$@"
}

echo Launching neovim server
echo
run-neovim-server.sh &

#echo Launching emacs server
#run-emacs-server.sh &

tmux_sessions=( $(tmux list-sessions -F "#{session_name}") )

(( $#tmux_sessions == 1 )) && {
	echo Only one tmux session : renaming it to principal
	echo
	tmux rename-session principal

	echo Creating tmux session simple
	echo
	tmux new-session -t simple -d

	echo Creating tmux session ssh
	echo
	tmux new-session -t ssh -d
}

echo Going to first workspace
echo
hc use_index 0

echo Launching kitty
echo
kitty --single-instance tmux attach-session -t principal &
sleep 1

echo Splitting
echo
hc split bottom 0.618
hc focus down

# echo Launching kitty
# echo
# kitty --single-instance &
# sleep 1

echo Launching vifm
echo
run-vifm.zsh &
sleep 2
hc focus up

echo Going to third workspace
echo
hc use_index 2

echo Launching neovim client
echo
run-neovim-qt-client.sh &
sleep 1

echo Splitting
echo
hc split bottom 0.618
hc focus down
hc set_layout horizontal

echo Launching kitty
echo
kitty --single-instance tmux attach-session -t simple &
sleep 2
hc focus up

echo Going to fifth workspace
echo
hc use_index 4
qutebrowser &

#echo Emacs should be automatically at the right place
#echo Launching emacs client
#run-emacs-client.sh &
