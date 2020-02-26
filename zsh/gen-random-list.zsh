#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

#setopt null_glob

#zmodload -i zsh/mathfunc

#zmodload zsh/regex

# }}}

# Initialisation {{{1

float ecart=1

racine=~/graphix/list

fichier=$racine/wallpaper.meta

# }}}1

# {{{ Arguments

numarg=$#

aide=0
numhist=0

nombres=()
fanions=()
autres=()

while true
do
	case $1 in
		-h)
			aide=1
			;;
		[0-9.]##)
			nombres+=$1
			shift
			;;
		-*)
			fanions+=$1
			shift
			;;
		?*)
			autres+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

(( $#nombres > 0 )) && ecart=$nombres[1]
(( $#autres > 0 )) && fichier=$autres[1]

# }}}

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "$(basename $0) : generate shuffled list with [0-9A-Z]-* priorities in filenames"
	echo
	echo "Usage: $(basename $0) "
	exit 0
}

# }}}1

# Scores {{{1

typeset -A scores

integer note=31

for char in {0..9} {a..u}
do
	(( note -= 1 ))
	scores[$char]=$note
done

for char in {v..z}
do
	(( note -= 100 ))
	scores[$char]=$note
done

# for key val in ${(kv)scores}; do
#     echo "$key -> $val"
# done

# }}}1

# Lecture {{{1

include=()
englobe=()
exclude=()
repertoire=()

racine=$(grep '^root' $fichier | cut -d ' ' -f 2)
include=($(grep '^include' $fichier | cut -d ' ' -f 2))
englobe=($(grep '^glob' $fichier | cut -d ' ' -f 2))
exclude=($(grep '^exclude' $fichier | cut -d ' ' -f 2))
repertoire=($(grep '^folder' $fichier | cut -d ' ' -f 2))

echo "Racine = $racine"

# }}}1
