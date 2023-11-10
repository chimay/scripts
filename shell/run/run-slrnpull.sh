#! /usr/bin/env sh

folder=~/racine/news/spool
server=news.eternal-september.org

slrnpull -d $folder --expire
slrnpull -d $folder -h $server --new-groups
