#!/usr/bin/env sh

# List videos in playlists

file=${1:-playlists.db}
string=$2

#jq '[ .videos.[] | { "title" : .title, "author" : .author } ]' $file
#jq '[ .videos.[] | select(.title | test("^.*'$string'.*$")) ]' $file | grep -v '^\[\]$'
#jq '. | select(.playlistName | test("^.*'$string'.*$"))' $file | grep -v '^\[\]$'

echo
echo "---- playlists ----"
echo
jq '. | select(.playlistName | test("'$string'"; "i"))' $file | grep playlistName

echo
echo "---- author ----"
echo
jq '. | select(.videos.[].author | test("'$string'"; "i"))' $file | grep playlistName | uniq


echo
echo "---- title ----"
echo
jq '. | select(.videos.[].title | test("'$string'"; "i"))' $file | grep playlistName | uniq
