#!/usr/bin/env sh

exec syncthing serve --no-browser >> ~/log/syncthing.log 2>&1
