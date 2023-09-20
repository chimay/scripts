#! /usr/bin/env sh

export NVIM_APPNAME=$1
shift

exec nvim "$@"
