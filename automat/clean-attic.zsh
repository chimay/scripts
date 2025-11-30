#! /usr/bin/env zsh

# unmodified since N days

delai_tres_court=${1:-7}
delai_court=${2:-30}
delai=${3:-60}
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

echo trash
echo "____________________________________________________________"
echo
echo "trash-empty -f $delai_court"
echo

trash-empty -f $delai_court

# vifm trash {{{1

cd ~/racine/trash/vifm

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

# varia {{{1

cd ~/racine/varia

echo
pwd
echo "____________________________________________________________"
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
		trash-put $element
	done
}

#  w3m cache  {{{1

cd ~/racine/config/webrowser/w3m

echo
pwd
echo "____________________________________________________________"
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
		trash-put $element
	done
}

# mpv watch_later  {{{1

cd ~/racine/local/state/mpv/watch_later

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(*(.m+$delai_tres_long))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

# syncron {{{1

cd ~/racine/syncron

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(spool/**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

# log {{{1

cd ~/log

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(**/*(.m+$delai))

(( $#dusty > 0 )) && {

	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

# dot cache {{{1

cd ~/.cache

echo
pwd
echo "____________________________________________________________"
echo

for element in **/*(.m+$delai_court)
do
	ls -l $element
	echo
	echo "trash-put $element"
	trash-put $element
done

echo

# clipmenu {{{1

cd ~/racine/hist/clipmenu

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(**/*(.m+$delai))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

echo

# emacs native compilation cache {{{1

cd ~/racine/dotdir/emacs.d/eln-cache

echo
pwd
echo "____________________________________________________________"
echo

dusty=()

dusty+=(**/*(.m+$delai_tres_long))

(( $#dusty > 0 )) && {
	ls -l $dusty
	echo
	for element in $dusty
	do
		echo "trash-put $element"
		trash-put $element
	done
}

echo
