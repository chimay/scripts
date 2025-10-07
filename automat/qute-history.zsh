#!/usr/bin/env zsh

# vim: set filetype=zsh:

localdir=$HOME/.local/share/qutebrowser

indexdir=$HOME/racine/index/webrowser/qutebrowser

cp -v $localdir/history.dmenu $indexdir/history.dmenu 1>&2
echo 1>&2

{
	cat $indexdir/history.dmenu

	sqlite3 -line \
		$localdir/history.sqlite \
		'select * from history' | \
		grep url | sed 's/     url = //'

} | sort | uniq >! $localdir/history.dmenu

sed -i '/duckduckgo.com/d' $localdir/history.dmenu
sed -i '/google.com/d' $localdir/history.dmenu
sed -i '/google.be/d' $localdir/history.dmenu
sed -i '/google.fr/d' $localdir/history.dmenu
sed -i '/youtube.com/d' $localdir/history.dmenu
sed -i '/windy.com../d' $localdir/history.dmenu
sed -i '/192.168.1.1/d' $localdir/history.dmenu

cp -v $localdir/history.dmenu $indexdir/history.dmenu 1>&2
echo 1>&2

echo Nombre de lignes : `wc -l $localdir/history.dmenu` 1>&2
echo 1>&2
echo Nombre de lignes : `wc -l $indexdir/history.dmenu` 1>&2
echo 1>&2
