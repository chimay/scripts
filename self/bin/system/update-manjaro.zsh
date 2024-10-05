#!/usr/bin/env zsh

# player {{{1

player () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/bell/$fu_fichier
	}

	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# clean cache {{{1

sudo pacman -Scc

# check site {{{1

w3m https://archlinux.org

# update mirrors {{{1

#sudo pacman-mirrors --fasttrack
sudo pacman-mirrors --country Germany --timeout 5

# refresh {{{1

sudo pacman -Syy

# new keys {{{1

# the manjaro pacman should to it by itself
#sudo pacman -S manjaro-keyring

# update {{{1

sudo pacman -Syyu

# playing {{{1

fini=$HOME/audio/bell/notification/fini.ogg
integer volume=70

player $volume $fini

# remove orphans {{{1

sudo pacman -Qdtq | sudo pacman -Rns -

# update files db {{{1

sudo pacman -Fy
#sudo pkfile -u
