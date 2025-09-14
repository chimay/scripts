#! /usr/bin/env sh

xdotool search --class "firefox" windowactivate && exit 0

quota=${1:-150}

exec systemd-run --user --scope -p CPUQuota="$quota%" firefox >> ~/log/firefox.log 2>&1
