#!/bin/sh

reper=~/racine/config/auto

sed-vars.zsh $reper/crontab > $reper/crontab-$HOST

crontab $reper/crontab-$HOST

crontab -l
