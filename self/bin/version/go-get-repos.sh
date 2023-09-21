#! /usr/bin/env sh

# vim: set fdm=indent:

cd ~/racine/bin/go

[[ -d src/github.com/edi9999/path-extractor ]] || {

	echo "go get github.com/edi9999/path-extractor/path-extractor"

	go get github.com/edi9999/path-extractor/path-extractor
}

