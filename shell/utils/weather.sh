#!/usr/bin/env sh

location=${1:-London}

curl -A 'curl/8.0' "https://wttr.in/$location"
