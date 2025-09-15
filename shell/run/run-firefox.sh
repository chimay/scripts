#! /usr/bin/env sh

xdotool search --class "firefox" windowactivate && exit 0

# cpu quota
#
# 50 % = 1/2 core
# 100 % = 1 core
# 150 % = 1 core 1/2
# 200 % = 2 cores
# 300 % = 3 cores
# 400 % = 4 cores

quota=${1:-150}

exec systemd-run --user --scope -p CPUQuota="$quota%" firefox >> ~/log/firefox.log 2>&1
