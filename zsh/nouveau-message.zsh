#!/usr/bin/env zsh

neuf=${1:-"?"}
lire=${2:-"?"}

message=$HOME/audio/sonnerie/notification/mesange.ogg

echo "loadfile $message append-play" > ~/racine/run/pipe/mpv

echo "set volume 100" > ~/racine/run/pipe/mpv

notify-send 'Nouveau(x) message(s) !' "$neuf nouveaux, $lire non lus."
