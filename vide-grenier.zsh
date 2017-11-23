#! /usr/bin/env zsh

delai=${1:-30}

# Syncron {{{1

cd ~/racine/syncron

pwd
echo

poussiereux=()

poussiereux+=(gmail/**/*(.m+$delai))
poussiereux+=(spool/**/*(.m+$delai))
poussiereux+=(tablet/**/*(.m+$delai))

(( $#poussiereux > 0 )) && {

	ls -l $poussiereux
	echo

	for element in $poussiereux
	do
		echo "rm -f $element"

		rm -f $element
	done
}

# }}}1

# Dot Cache {{{1

cd ~/.cache

pwd
echo

poussiereux=()

poussiereux+=(mutt/**/*(.m+$delai))

(( $#poussiereux > 0 )) && {

	ls -l $poussiereux
	echo

	for element in $poussiereux
	do
		echo "rm -f $element"

		rm -f $element
	done
}

# }}}1
