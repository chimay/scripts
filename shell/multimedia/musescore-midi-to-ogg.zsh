#!/usr/bin/env zsh

# vim: set filetype=zsh:

# Variables {{{1

#musescore=/usr/bin/musescore
musescore=/usr/bin/mscore

# }}}1

# {{{ Arguments

oggdir=.

argumen=()

while true
do
	case $1 in
		-d)
			shift
			oggdir=$1
			shift
			;;
		?*)
			argumen+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

[ -e $oggdir -a ! -d $oggdir ] && {
	echo Ogg dir must be a directory
	echo
	exit 1
}

[ -d $oggdir ] || mkdir -p $oggdir

# }}}

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 '[-d lily-dest-dir] file(s)'
	echo
	echo Convert musescore files to lilypond
	exit 0
}

# }}}1

# Boucle {{{1

for midi in $=argumen
do
	[[ $midi = */* ]] || {
		midi=./$midi
	}

	musedir=${midi%/*}

	echo "cd $musedir"

	cd $musedir

	midi=${midi#$PWD/}

	# ogg dir

	echo
	echo "cd $oggdir"

	cd $oggdir

	ogg=${midi%.midi}.ogg

	[ ! -f $ogg -o $midi -nt $ogg ] && {
		echo
		echo "$musescore -o $ogg $midi"
		echo
		$musescore -o $ogg $midi
	}

	# back to last dir

	echo
	echo "cd -"

	cd -
done

# }}}1
