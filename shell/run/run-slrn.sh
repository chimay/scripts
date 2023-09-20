#! /usr/bin/env zsh

cd ~/racine/config/news

cp newsrc jnewsrc
cp newsrc ~/.newsrc

exec slrn "$@"
