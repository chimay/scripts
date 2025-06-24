#!/usr/bin/env sh

repo=$1

git clone --depth 1 --filter=blob:none $repo
