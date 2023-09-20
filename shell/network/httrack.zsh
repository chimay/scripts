#! /usr/bin/env zsh

site=$1

httrack \
	--mirrorlinks \
	--near \
	$site
