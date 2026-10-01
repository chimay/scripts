#!/usr/bin/env sh

[ -d /run/media ] || {
	echo "sudo mkdir -p /run/media"
	echo
	sudo mkdir -p /run/media
}

[ -d /run/media/david ] || {
	echo "sudo mkdir -p /run/media/david"
	echo
	sudo mkdir -p /run/media/david
}
