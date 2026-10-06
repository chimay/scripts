#!/usr/bin/env sh

title=${1:-1}

cvlc dvd:///dev/sr0#$title \
	--avcodec-hw=none \
	--sout '#transcode{vcodec=h264,vb=2500,acodec=mp4a,ab=128,channels=2}:std{access=http,mux=ts,dst=:8080}' \
	--sout-http-mime="video/mp2t" \
	--sout-keep

