#!/usr/bin/env zsh

# vim: set filetype=zsh:

# Variables {{{1

#musescore=/usr/bin/musescore
musescore=/usr/bin/mscore

# }}}1

# {{{ Arguments

mp_dir=.

argumen=()

while true
do
	case $1 in
		-d)
			shift
			mp_dir=$1
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

[ -e $mp_dir -a ! -d $mp_dir ] && {
	echo mp3 dir must be a directory
	echo
	exit 1
}

[ -d $mp_dir ] || mkdir -p $mp_dir

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

	# mp3 dir

	echo
	echo "cd $mp_dir"

	cd $mp_dir

	mpfile=${midi%.midi}.mp3

	[ ! -f $mpfile -o $midi -nt $mpfile ] && {
		echo
		echo "$musescore -o $mpfile $midi"
		echo
		$musescore -o $mpfile $midi
	}

	# back to last dir

	echo
	echo "cd -"

	cd -
done

# }}}1
