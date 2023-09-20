#! /usr/bin/env zsh

delai_tres_court=${1:-7}
delai_court=${2:-30}
delai=${3:-100}
delai_long=${4:-120}
delai_tres_long=${5:-360}

# checks {{{1

[[ -x =trash-put ]] || {

	echo "error : trash-put not found"
	echo
	exit 1
}

#  timestamp {{{1

echo
echo "============================================================"
echo "    clean attic $(date +'%A %d %B %Y %H:%M')"
echo "============================================================"
echo

# trash bin {{{1

echo Corbeille
echo "------------------------------------------------------------"
echo
echo "trash-empty -f $delai_long"
echo

trash-empty -f $delai_long

# vifm trash {{{1

cd ~/racine/trash/vifm

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

# varia {{{1

cd ~/racine/varia

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(autosave/**/*(.m+$delai))
dusty+=(backup/**/*(.m+$delai))
dusty+=(data/**/*(.m+$delai))
dusty+=(temp/**/*(.m+$delai))

dusty+=(undo/**/*(.m+$delai_tres_long))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

# tmux resurrect {{{1

cd ~/racine/config/multiplex/tmux/repertoire/resurrect

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

#  w3m cache  {{{1

cd ~/racine/config/webrowser/w3m

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(w3mcache*(.m+$delai_tres_court))
dusty+=(w3mtmp*(.m+$delai_tres_court))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

# mpv watch_later  {{{1

cd ~/racine/config/multimedia/mpv/watch_later

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(*(.m+$delai_tres_long))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

#  freetube {{{1

cd ~/racine/feder/central/freetube

pwd
echo "------------------------------------------------------------"
echo

for folder in *(/)
do
	dusty=($folder/**/*(.om[4,1000]))
	(( $#dusty > 0 )) || continue
	echo "trash-put $=dusty"
	echo
	trash-put $=dusty
done

# syncron {{{1

cd ~/racine/syncron

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(spool/**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

# log {{{1

cd ~/log

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(**/*(.m+$delai))

(( $#dusty > 0 )) && {

	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

# dot cache {{{1

cd ~/.cache

pwd
echo "------------------------------------------------------------"
echo

dusty=()

dusty+=(mutt/**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		echo
		trash-put $element
	done
}

echo
