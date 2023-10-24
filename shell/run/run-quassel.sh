#! /usr/bin/env sh

pgrep quasselcore || quasselcore \
	--configdir ~/racine/config/social/quasselcore \
	--logfile ~/log/quasselcore.log &
sleep 12
pgrep quasselclient || quasselclient --hidewindow >> ~/log/quasselclient.log 2>&1
