#!/usr/bin/env zsh

# vim: set filetype=zsh:

argumen=($@)

# Aide {{{1

[ $#argumen -eq 0 ] && {
	echo Usage : $0 ' file(s)'
	echo
	echo Convert midi files to ogg
	exit 0
}

# }}}1

# Boucle {{{1

for midi in $=argumen
do
	ogg=${midi%.midi}.ogg
	echo
	echo "timidity -s 44100 -Ov -o $ogg $midi"
	echo
	timidity -Ov -o $ogg $midi
done

# }}}1
