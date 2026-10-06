#!/usr/bin/env sh

export WLR_BACKENDS=headless
export WLR_HEADLESS_OUTPUTS=1
export SWAYSOCK=/run/user/1001/sway-ipc.1001.1454083.sock

echo "sway"
echo

sway

# swaymsg -t get_outputs
