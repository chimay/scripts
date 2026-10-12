#!/usr/bin/env sh

uid=$(id -u)

ip -4 a

export XDG_RUNTIME_DIR=/run/user/$uid
export WAYLAND_DISPLAY=wayland-1

echo
echo "wayvnc 0.0.0.0 5900"
echo
wayvnc 0.0.0.0 5900

# ss -ltnp | grep 5900
