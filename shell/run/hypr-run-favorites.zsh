#!/usr/bin/env zsh

#export PATH=$PATH:~/racine/shell/run

hl() {
    hyprctl "$@"
}

echo Launching neovim server
echo
run-neovim-server.sh &
sleep 1

echo Going to first workspace
echo
hl dispatch 'hl.dsp.focus({ workspace = "1" })'
sleep 1

echo Launching kitty
echo
kitty --single-instance &

echo Launching vifm
echo
run-vifm.zsh &
sleep 1

echo Going to third workspace
echo
hl dispatch 'hl.dsp.focus({ workspace = "3" })'
sleep 1

echo Launching kitty
echo
kitty --single-instance &

echo Launching neovim client
echo
run-neovim-qt-client.sh &
