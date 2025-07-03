#! /usr/bin/env zsh

path+=(~/racine/bin/local/bin)

navigateur=${1:-qutebrowser}

#rofi-bookmarks ~/racine/config/webrowser/bookmarks

BROWSER=$navigateur buku_run
