#!/bin/bash

# credit : https://askubuntu.com/questions/1029250/ubuntu-18-04-ethernet-disconnected-after-suspend
# make it executable and copy it to /lib/systemd/system-sleep/

PROGNAME=$(basename "$0")
state=$1
action=$2

function log {
    logger -i -t "$PROGNAME" "$*"
}

log "Running $action $state"

if [[ $state == post ]]; then
    modprobe -r r8169 \
    && log "Removed r8169" \
    && modprobe -i r8169 \
    && log "Inserted r8169"
fi
