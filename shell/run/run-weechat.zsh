#! /usr/bin/env zsh

cd ~/racine/config/chaton/weechat

for fichier in *.perso
do
        echo "command cp -f $fichier ${fichier%%.perso}"

        command cp -f $fichier ${fichier%%.perso}
done

exec weechat "$@"
