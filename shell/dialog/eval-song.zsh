#!/usr/bin/env zsh

emulate -R zsh
setopt local_options
setopt warn_create_global
setopt null_glob
zmodload zsh/regex

path+=(~/racine/shell/filesys)

evaluation='NONE'
root=${1:-~/audio}

evaluation=$(\
	zenity \
	--title "Song" \
	--forms \
	--add-entry "evaluation" \
)

# Minuscules ?
#evaluation=${evaluation:l}

# Majuscules ?
evaluation=${evaluation:u}

name=`mpc -f "%file%" | awk '{ if ( NR == 1 ) print $0 }'`

name=${root}/${name}

evaluation.zsh $evaluation $name >>| ~/log/eval-song.log
