#!/usr/bin/env sh

#export PATH=$PATH:~/racine/shell/run

echo $PATH

hc() {
    herbstclient "$@"
}

echo Launching neovim server
run-neovim-server.sh &
#echo Launching emacs server
#run-emacs-server.sh &

echo Going to first workspace
hc use_index 0
kitty &
sleep 1
echo Splitting
hc split bottom 0.618
hc focus down
kitty &
sleep 1

echo Going to second workspace
hc use_index 2
sleep 2
echo Launching neovim client
run-neovim-qt-client.sh &
sleep 1
echo Splitting
hc split bottom 0.618
hc focus down
hc set_layout horizontal
echo Launching gvim
run-gvim.sh -c "cd ~/racine/public" &

echo Going to fifth workspace
hc use_index 4
qutebrowser &

#echo Emacs should be automatically at the right place
#echo Launching emacs client
#run-emacs-client.sh &
