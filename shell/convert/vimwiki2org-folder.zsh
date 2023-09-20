#!/usr/bin/env zsh

wikidir=${1:-~/racine/wiki}
orgdir=${2:-~/racine/organ}

cd $wikidir

for folder in . **/*(/)
do
	echo "cd $wikidir/$folder"
	cd $wikidir/$folder
	destdir=$orgdir/$folder
	[ -d $destdir ] || {
		echo "mkdir -p $destdir"
		mkdir -p $destdir
	}
	for wikifile in *.wiki
	do
		orgfile=${wikifile%%.*}.org
		echo "vimwiki2org.pl $wikifile >! $destdir/$orgfile"
		vimwiki2org.sed $wikifile >! $destdir/$orgfile
	done
done
