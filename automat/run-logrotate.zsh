#! /usr/bin/env zsh

echo
echo "========================================================================"
echo
date +"    [=] %A %d %B %Y  (o) %H:%M  | %:z | "
echo
echo "========================================================================"
echo

fichier=${1:-"log-$HOST"}

echo Fichier de configuration : $fichier
echo

exec logrotate --verbose \
	--state ~/run/logrotate/status \
	~/racine/config/auto/logrotate/$fichier
