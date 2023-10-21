#! /usr/bin/env sh

quasselcore \
	--configdir ~/racine/config/social/quasselcore \
	--logfile ~/log/quasselcore.log &
sleep 12
quasselclient --hidewindow >>! ~/log/quasselclient.log 2>&1 &
