#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

localdir=$HOME/.local/share/qutebrowser

indexdir=$HOME/racine/index/qutebrowser

cp -v $localdir/history.dmenu $indexdir/history.dmenu 1>&2
echo 1>&2

{
	cat $indexdir/history.dmenu

	sqlite3 -line \
		$localdir/history.sqlite \
		'select * from history' | \
		grep url | sed 's/     url = //'

} | sort | uniq >! $localdir/history.dmenu

echo Nombre de lignes : `wc -l $localdir/history.dmenu` 1>&2
echo Nombre de lignes : `wc -l $indexdir/history.dmenu` 1>&2
echo 1>&2
