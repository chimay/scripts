#! /usr/bin/env zsh

fichier=$1

type_fichier=$(file -L -z $fichier) || type_fichier=$(file -L $fichier)

if [[ $type_fichier = *:*PDF* ]]
then
	exec pdftotext $fichier -

elif [[ $fichier = *.html ]]
then
	exec w3m -dump $fichier

elif [[ $type_fichier = *:*OpenDocument* ]]
then
	exec odt2txt $fichier

elif [[ $type_fichier = *:*(PNG|JPEG|GIF)*image* ]]
then
	exec exiv2 pr $fichier

elif [[ $type_fichier = *:*Ogg*Vorbis*audio* ]]
then
	exec ogginfo $fichier

elif [[ $type_fichier = *:*MPEG*ADTS*layer*III* ]]
then
	exec mediainfo $fichier

fi
