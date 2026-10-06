#!/bin/sh

zenity --info \
    --title="DVD streaming" \
    --text="Start VLC, then click OK and select its window."

winid=$(xwininfo | awk '/Window id:/ {print $4}')

if [ -z "$winid" ]; then
    zenity --error --text="No window selected."
    exit 1
fi

echo "Selected VLC window: $winid"

ffmpeg \
    -f x11grab \
    -framerate 25 \
    -window_id "$winid" \
    -i :0 \
    -f pulse \
    -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor \
    -map 0:v:0 \
    -map 1:a:0 \
    -c:v libx264 \
    -preset ultrafast \
    -tune zerolatency \
    -pix_fmt yuv420p \
    -b:v 2500k \
    -c:a aac \
    -b:a 128k \
    -ac 2 \
    -ar 48000 \
    -f mpegts \
    -listen 1 \
    http://0.0.0.0:8080
