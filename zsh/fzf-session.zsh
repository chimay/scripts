#!/usr/bin/env /bin/zsh

fichier=$(print -l ~/racine/config/multiplex/tmux/session/* | grep -v Grenier | fzf)

(( $#fichier == 0 )) && exit 0

tmux source-file $fichier
