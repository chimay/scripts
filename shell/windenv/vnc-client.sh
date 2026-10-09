#!/usr/bin/env sh

user=$(id -un)
server=${1:-universe.local}

port=5900

# -- time to change workspace

sleep 2

#vncviewer $server$DISPLAY

echo "vncviewer -via $user@$server localhost$DISPLAY"
echo

vncviewer -via $user@$server localhost$DISPLAY
