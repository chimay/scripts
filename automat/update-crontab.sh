#!/bin/sh

reper=~/racine/config/auto

sed-vars.zsh $reper/crontab > $reper/crontab-$HOST

echo
echo "------------------------------------------------------------"
echo
echo "Date & Heure : `date +'%A %d %B %Y  --  %H:%M'`"
echo

crontab $reper/crontab-$HOST

crontab -l
