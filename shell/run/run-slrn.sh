#! /usr/bin/env sh

cd ~/racine/config/news || exit
cp -f newsrc.slrnpull jnewsrc

run-slrnpull.sh

exec slrn "$@"
