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
