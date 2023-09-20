#! /usr/bin/env sh

appname=$1
shift

export NVIM_APPNAME=$appname

exec nvim-qt "$@" >> ~/log/$appname-qt.log 2>&1
