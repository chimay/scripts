#! /usr/bin/env zsh

repertoire=~/nouvelles/spool

serveur=news.gmane.org

slrnpull=/usr/local/bin/slrnpull

# Make sure that all files will be readable by others

#umask 022

# Before getting new articles, perform expiration.

$slrnpull -d $repertoire --expire

# On télécharge les nouveaux articles

$slrnpull -d $repertoire -h $serveur
