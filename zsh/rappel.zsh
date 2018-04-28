#! /usr/bin/env zsh

temps=($*)

shift

alarme=(sonnerie.zsh $HOME/audio/Sonnerie/notification/generique.ogg)

echo $alarme | at $temps

echo

atq
