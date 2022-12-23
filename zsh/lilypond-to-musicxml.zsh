#!/usr/bin/env /bin/zsh

# Arguments {{{1

xmldir=.

argumen=()

while true
do
	case $1 in
		-d)
			shift
			xmldir=$1
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

[ -e $xmldir -a ! -d $xmldir ] && {
	echo Lilypond dir must be a directory
	echo
	exit 1
}

[ -d $xmldir ] || mkdir -p $xmldir

# }}}1

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 '[-d xml-dest-dir] file(s)'
	echo
	echo Convert lilypond files to xml
	exit 0
}

# }}}1

# Boucle {{{1

for score in $=argumen
do
	lilydir=${score%/*}

	echo "cd $lilydir"

	cd $lilydir

	score=${score#$PWD/}
	xml=$xmldir/${score%.*}.musicxml

	echo "ly musicxml -o $xml $score"
	echo
	ly musicxml -o $xml $score
	echo
done

# }}}1
