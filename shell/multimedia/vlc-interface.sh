#!/usr/bin/env sh

# username is :
# - empty
# - vlchttp

vlc dvd:///dev/sr0 \
	--avcodec-hw=none \
    --extraintf=http \
    --http-host=0.0.0.0 \
    --http-port=8080 \
	--http-password='dvd'
