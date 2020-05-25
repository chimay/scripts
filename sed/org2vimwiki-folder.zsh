#!/usr/bin/env zsh

orgdir=${1:-~/racine/site/orgmode}
wikidir=${2:-~/racine/wiki/site/wiki}

cd $orgdir

for folder in . **/*(/)
do
	echo "cd $orgdir/$folder"
	cd $orgdir/$folder
	destdir=$wikidir/$folder
	[ -d $destdir ] || {
		echo "mkdir -p $destdir"
		mkdir -p $destdir
	}
	for orgfile in *.org
	do
		wikifile=${orgfile%%.*}.wiki
		echo "org2vimwiki.sed $orgfile >! $destdir/$wikifile"
		org2vimwiki.sed $orgfile >! $destdir/$wikifile
	done
done
