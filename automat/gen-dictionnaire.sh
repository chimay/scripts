#!/usr/bin/env sh

fichier=$1

tr -s "[[:blank:]]" "\n" < $1
