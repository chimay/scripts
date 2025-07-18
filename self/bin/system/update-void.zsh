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

# refresh {{{1

sudo xbps-install -S

# clean cache {{{1

sudo xbps-remove -O

# check site {{{1

w3m https://voidlinux.org/news/

# new keys {{{1



# update {{{1

sudo xbps-install -Su

# playing {{{1

fini=$HOME/audio/bell/notification/fin-mise-a-jour.ogg
integer volume=100

player $volume $fini

# config diff {{{1



# remove orphans {{{1

sudo xbps-remove -o

# update files db {{{1

xlocate -S
