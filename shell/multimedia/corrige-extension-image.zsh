#! /usr/bin/env zsh

# {{{ Options de zsh

setopt null_glob
setopt extended_glob

# }}}

repertoire=${1:-~/img}

cd $repertoire

# {{{ SVG --> *

echo "SVG --> *"

file (#i)**/*.svg | grep 'PNG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.png"
	mv $fichier ${racine}.png
done

file (#i)**/*.svg | grep 'JPEG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.jpg"
	mv $fichier ${racine}.jpg
done

# }}}

# {{{ PNG --> *

echo "PNG --> *"

file (#i)**/*.png | grep 'SVG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.svg"
	mv $fichier ${racine}.svg
done

file (#i)**/*.png | grep 'JPEG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.jpg"
	mv $fichier ${racine}.jpg
done

# }}}

# {{{ JPG --> *

echo "JPG --> *"

file (#i)**/*.jpg (#i)**/*.jpeg | grep 'SVG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.svg"
	mv $fichier ${racine}.svg
done

file (#i)**/*.jpg (#i)**/*.jpeg | grep 'PNG' | awk '{ print $1 }' | sed 's/://' | while read fichier
do
	racine=${fichier%.*}
	echo "mv $fichier ${racine}.png"
	mv $fichier ${racine}.png
done

# }}}

cd -
