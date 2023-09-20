#! /usr/bin/env zsh

level=$1
domains=$2
site=$3

wget \
	--no-parent \
	--page-requisites \
	--ignore-case \
	--reject .mid,.midi,.mp3,.ogg,.wav,.ogv,.m4v,.webm,.swf,.flv,.zip,.tar.gz,.tar.bz2 \
	--user-agent=firefox \
	--progress=bar \
	--recursive \
	--level=$level \
	--wait=3 \
	--random-wait \
	--convert-links \
	--adjust-extension \
	--timestamping \
	--no-remove-listing \
	--backups=0 \
	--span-hosts \
	--domains=$domains \
	--exclude-directories=page,category,author,comments,feed,tag,feed \
	-b \
	-o wget.log \
	$site
