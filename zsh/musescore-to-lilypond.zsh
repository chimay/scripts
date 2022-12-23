#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# Variables {{{1

#musescore=/usr/bin/musescore
musescore=/usr/bin/mscore

# }}}1

# {{{ Arguments

lilydir=.

argumen=()

while true
do
	case $1 in
		-d)
			shift
			lilydir=$1
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

[ -e $lilydir -a ! -d $lilydir ] && {
	echo Lilypond dir must be a directory
	echo
	exit 1
}

[ -d $lilydir ] || mkdir -p $lilydir

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

for score in $=argumen
do
	musedir=${score%/*}

	echo "cd $musedir"

	cd $musedir

	score=${score#$PWD/}

	# music xml bridge

	xml=$lilydir/${score%.*}.mxl

	[ ! -f $xml -o $score -nt $xml ] && {
		echo
		echo "$musescore -o $xml $score"
		echo
		$musescore -o $xml $score
	}

	# lilypond dir

	echo
	echo "cd $lilydir"

	cd $lilydir

	lily=${xml%.mxl}.ly

	[ ! -f $lily -o $xml -nt $lily ] && {
		echo
		echo "musicxml2ly -m $xml"
		echo
		musicxml2ly -m $xml
	}

	rm -f *.ly~

	# back to musescore

	echo
	echo "cd -"

	cd -
done

# }}}1
