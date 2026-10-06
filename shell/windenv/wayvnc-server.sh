#!/usr/bin/env sh

uid=$(id -u)

ip -4 a

export XDG_RUNTIME_DIR=/run/user/$uid
export WAYLAND_DISPLAY=wayland-1

echo "sway-headless.sh &"
echo
sway-headless.sh &

sleep 3

echo
echo "wayvnc -o HEADLESS-1 -k be 0.0.0.0 5900"
echo
wayvnc -o HEADLESS-1 -k be 0.0.0.0 5900

# ss -ltnp | grep 5900

killall sway
