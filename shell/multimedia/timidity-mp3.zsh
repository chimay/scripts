#!/usr/bin/env zsh

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
	mpthree=${midi%.midi}.mp3
	echo
	echo "timidity -s 44100 -Ow $midi -o - | lame -q 0 -b 128 - - > $mpthree"
	echo
	timidity -Ow $midi -o - | lame -q 0 -b 128 - - > $mpthree
done

# }}}1
