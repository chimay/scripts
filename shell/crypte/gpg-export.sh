#!/usr/bin/env sh

[ $# -eq 0 ] && {
	echo Usage : $0 userid
	echo
	exit 1
}

userid=$1

echo Exporting in gpg format
echo

gpg --export --output $userid.gpg $userid
gpg --export-secret-key --output $userid-secret.gpg $userid
gpg --export-secret-subkeys --output $userid-subkeys.gpg $userid

echo Exporting in ascii format
echo

gpg --export --armor --output $userid.asc $userid
gpg --export-secret-key --armor --output $userid-secret.asc $userid
gpg --export-secret-subkeys --armor --output $userid-subkeys.asc $userid
