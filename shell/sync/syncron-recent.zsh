#! /usr/bin/env zsh

# Documentation {{{1

# Option de rsync :
#
# -R = --relative : transmet les chemins relatifs complets à la destination

# Deux méthodes

# Méthode 1
# ------------------------------

# cd ~/racine
#
# syncron -R dir/**/*(D.m-$delai)

# Méthode 2
# ------------------------------

# Noter le ./ au milieu du chemin source :
#
# syncron -R ~/racine/./dir/**/*(D.m-$delai)

# }}}1

setopt extended_glob
setopt no_match
unsetopt null_glob

delai=${1:-91}
recent=${2:-~/racine/syncron/recent}

syncron () {
	rsync \
		--verbose \
		--progress \
		--stats \
		--human-readable \
		--itemize-changes \
		--log-file="$HOME/log/rsync.log" \
		--rsh=ssh \
		--recursive \
		--delete-during \
		--modify-window=1 \
		--owner \
		--group \
		--times \
		--perms \
		--links \
		--exclude-from=$HOME/racine/common/sync/rsync-exclude \
		--update \
		"$@"
}

cd ~/racine

echo
echo "============================================================"
echo "    Syncron recent $(date +'%A %d %B %Y %H:%M')"
echo "============================================================"
echo

setopt globdots

echo
echo "syncron -R plain/**/*(D.m-$delai) $recent"
echo
syncron -R plain/**/*(D.m-$delai) $recent

echo
echo "syncron -R dotdir/**/*(D.m-$delai) $recent"
echo
syncron -R dotdir/**/*(D.m-$delai) $recent

unsetopt globdots

echo
echo "syncron -R organ/**/*(D.m-$delai) $recent"
echo
syncron -R organ/**/*(D.m-$delai) $recent

# echo
# echo "syncron -R wiki/**/*(D.m-$delai) $recent"
# echo
# syncron -R wiki/**/*(D.m-$delai) $recent

echo
echo "syncron -R site/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent"
echo
syncron -R site/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent

echo
echo "syncron -R public/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent"
echo
syncron -R public/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent

echo
echo "syncron -R log/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent"
echo
syncron -R log/**/*~(*~|*.html|*.epub)(D.m-$delai) $recent

echo
echo "syncron -R artisan/**/*(D.m-$delai) $recent"
echo
syncron -R artisan/**/*(D.m-$delai) $recent

echo
echo "syncron -R pictura/**/*(D.m-$delai) $recent"
echo
syncron -R pictura/**/*(D.m-$delai) $recent

echo
echo "syncron -R musica/**/*(D.m-$delai) $recent"
echo
syncron -R musica/**/*(D.m-$delai) $recent

echo
echo "syncron -R litera/**/*(D.m-$delai) $recent"
echo
syncron -R litera/**/*(D.m-$delai) $recent

echo
echo "syncron -R science/**/*(D.m-$delai) $recent"
echo
syncron -R science/**/*(D.m-$delai) $recent

echo
echo "syncron -R liber/**/*(D.m-$delai) $recent"
echo
syncron -R liber/**/*(D.m-$delai) $recent

echo
echo "syncron -R shell/**/*(D.m-$delai) $recent"
echo
syncron -R shell/**/*(D.m-$delai) $recent

echo
echo "syncron -R fun/**/*(D.m-$delai) $recent"
echo
syncron -R fun/**/*(D.m-$delai) $recent

echo
echo "syncron -R automat/**/*(D.m-$delai) $recent"
echo
syncron -R automat/**/*(D.m-$delai) $recent

echo
echo "syncron -R install/**/*(D.m-$delai) $recent"
echo
syncron -R install/**/*(D.m-$delai) $recent

echo
echo "syncron -R prolang/**/*(D.m-$delai) $recent"
echo
syncron -R prolang/**/*(D.m-$delai) $recent

# Config {{{1

echo
echo "syncron -R config/artisan/**/*(D.m-$delai) $recent"
echo
syncron -R config/artisan/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/auto/**/*(D.m-$delai) $recent"
echo
syncron -R config/auto/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/cmdline/**/*(D.m-$delai) $recent"
echo
syncron -R config/cmdline/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/crypte/**/*(D.m-$delai) $recent"
echo
syncron -R config/crypte/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/edit/**/*(D.m-$delai) $recent"
echo
syncron -R config/edit/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/fileman/**/*(D.m-$delai) $recent"
echo
syncron -R config/fileman/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/infoman/**/*(D.m-$delai) $recent"
echo
syncron -R config/infoman/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/mail/**/*(D.m-$delai) $recent"
echo
syncron -R config/mail/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/mime/**/*(D.m-$delai) $recent"
echo
syncron -R config/mime/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/multimedia/**/*(D.m-$delai) $recent"
echo
syncron -R config/multimedia/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/multiplex/**/*(D.m-$delai) $recent"
echo
syncron -R config/multiplex/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/network/**/*(D.m-$delai) $recent"
echo
syncron -R config/network/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/news/**/*(D.m-$delai) $recent"
echo
syncron -R config/network/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/office/**/*(D.m-$delai) $recent"
echo
syncron -R config/office/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/organizer/**/*(D.m-$delai) $recent"
echo
syncron -R config/network/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/pack/**/*(D.m-$delai) $recent"
echo
syncron -R config/pack/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/print/**/*(D.m-$delai) $recent"
echo
syncron -R config/print/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/science/**/*(D.m-$delai) $recent"
echo
syncron -R config/science/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/script/**/*(D.m-$delai) $recent"
echo
syncron -R config/script/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/social/**/*(D.m-$delai) $recent"
echo
syncron -R config/social/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/system/**/*(D.m-$delai) $recent"
echo
syncron -R config/system/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/terminal/**/*(D.m-$delai) $recent"
echo
syncron -R config/terminal/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/utils/**/*(D.m-$delai) $recent"
echo
syncron -R config/utils/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/version/**/*(D.m-$delai) $recent"
echo
syncron -R config/version/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/virtual/**/*(D.m-$delai) $recent"
echo
syncron -R config/virtual/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/visu/**/*(D.m-$delai) $recent"
echo
syncron -R config/visu/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/webrowser/**/*(D.m-$delai) $recent"
echo
syncron -R config/webrowser/**/*(D.m-$delai) $recent

echo
echo "syncron -R config/windenv/**/*(D.m-$delai) $recent"
echo
syncron -R config/windenv/**/*(D.m-$delai) $recent

# }}}1

echo
echo "syncron -R multics/**/*(D.m-$delai) $recent"
echo
syncron -R multics/**/*(D.m-$delai) $recent

echo
echo "syncron -R filesys/**/*(D.m-$delai) $recent"
echo
syncron -R filesys/**/*(D.m-$delai) $recent

echo
echo "syncron -R network/**/*(D.m-$delai) $recent"
echo
syncron -R network/**/*(D.m-$delai) $recent

echo
echo "syncron -R self/**/*(D.m-$delai) $recent"
echo
syncron -R self/**/*(D.m-$delai) $recent

echo
echo "syncron -R list/**/*(D.m-$delai) $recent"
echo
syncron -R list/**/*(D.m-$delai) $recent

echo
echo "syncron -R index/**/*(D.m-$delai) $recent"
echo
syncron -R index/**/*(D.m-$delai) $recent

echo
echo "syncron -R refer/**/*(D.m-$delai) $recent"
echo
syncron -R refer/**/*(D.m-$delai) $recent

echo
echo "syncron -R hist/**/*(D.m-$delai) $recent"
echo
syncron -R hist/**/*(D.m-$delai) $recent

echo
echo "syncron -R snippet/**/*(D.m-$delai) $recent"
echo
syncron -R snippet/**/*(D.m-$delai) $recent

echo
echo "syncron -R example/**/*(D.m-$delai) $recent"
echo
syncron -R example/**/*(D.m-$delai) $recent

echo
echo "syncron -R plugin/data/**/*(D.m-$delai) $recent"
echo
syncron -R plugin/data/**/*(D.m-$delai) $recent

echo
echo "syncron -R common/**/*(D.m-$delai) $recent"
echo
syncron -R common/**/*(D.m-$delai) $recent

echo
echo "syncron -R feder/**/*(D.m-$delai) $recent"
echo
syncron -R feder/**/*(D.m-$delai) $recent

echo
echo "syncron -R hub/**/*(D.m-$delai) $recent"
echo
syncron -R hub/**/*(D.m-$delai) $recent

echo
echo "syncron -R omni/**/*(D.m-$delai) $recent"
echo
syncron -R omni/**/*(D.m-$delai) $recent

echo
echo "syncron -R repo/**/*(D.m-$delai) $recent"
echo
syncron -R repo/**/*(D.m-$delai) $recent

echo
echo "syncron -R template/**/*(D.m-$delai) $recent"
echo
syncron -R template/**/*(D.m-$delai) $recent

echo
echo "syncron -R test/**/*(D.m-$delai) $recent"
echo
syncron -R test/**/*(D.m-$delai) $recent
