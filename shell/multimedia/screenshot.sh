#!/bin/sh

delay=$1
shift

scrot -d $delay -c -s "$@"
