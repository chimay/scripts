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

# refresh {{{1

sudo pacman -Syy

# new keys {{{1

sudo pacman -S artix-keyring archlinux-keyring

# update {{{1

sudo pacman -Syyu

# playing {{{1

fini=$HOME/audio/bell/notification/fin-mise-a-jour.ogg
integer volume=100

player $volume $fini

# pacnews {{{1

sudo pacdiff -s

# remove orphans {{{1

sudo pacman -Qdtq | sudo pacman -Rns -

# update files db {{{1

sudo pacman -Fy
sudo pkfile -u
