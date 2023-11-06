#! /usr/bin/env zsh

# Options {{{1

emulate -R zsh

setopt extended_glob

setopt clobber


# Documentation {{{1

# Utile pour les extensions
# Plus nécessaire avec file <fichier>

#unsetopt case_glob

# Si on ne souhaite pas désactiver case_glob,
# on peut faire :
#
# (#i)(blabla)*
#
# pour demander une correspondance insensible à la casse
# (requiert l’activation de extended_glob)


export PROFONDEUR=${PROFONDEUR:-0}

(( PROFONDEUR += 1 ))

fichier=$1

type_fichier=$(file -L -z $fichier) || type_fichier=$(file -L $fichier)

# Non existant {{{1

[[ -e $fichier ]] || {

	echo "Le fichier $fichier n’existe pas." >& 2
	echo >& 2

	exit 1
}


# Liens symboliques {{{1

[[ -L $fichier ]] && {

	lilien='readlink'

	(( PROFONDEUR > 10 )) && {

		echo "Beaucoup de niveaux de liens symboliques :"
		echo "On va directement à la cible"

		lilien='readlink -f'
	}

	echo
	echo "Le fichier $fichier est un lien symbolique : "
	echo

	target=$($=lilien $fichier)

	echo "$fichier -> " $target
	echo

	echo "cd $(dirname $fichier)"
	cd $(dirname $fichier)
	echo

	less $target

	exit 0
}


# Répertoire {{{1

[[ -d $fichier ]] && {

	echo "exec tree -C -A $fichier"
	echo

	exec tree -C -A $fichier
}


# PDF {{{1

[[ $type_fichier = *:*PDF* ]] && {

	echo "exec pdftotext $fichier -"
	echo

	exec pdftotext $fichier -
}


# PDF compressed with XZ {{{1

[[ $fichier = *.pdf.xz ]] && {

	# Ne fonctionne pas

	echo "exec pdftotext <(xz -dc $fichier) -"
	echo

	exec pdftotext <(xz -dc $fichier) -
}

# json {{{1

[[ $fichier = *.json ]] && {

	exit 1
}

# html {{{1

[[ $fichier = *.html ]] && {

	echo "exec w3m -dump $fichier"
	echo

	exec w3m -dump $fichier
}


# OpenDocument {{{1

[[ $type_fichier = *:*OpenDocument* ]] && {

	echo "exec odt2txt $fichier"
	echo

	exec odt2txt $fichier
}


# word {{{1

[[ $fichier = *.doc ]] && {

	echo "exec antiword $fichier"
	echo

	exec antiword $fichier
}


# docx {{{1

[[ $fichier = *.docx ]] && {

	echo "exec docx2txt $fichier -"
	echo

	exec docx2txt $fichier -
}


#  {{{ RTF

[[ $fichier = *.rtf ]] && {

	echo "exec catdoc -a $fichier"
	echo

	exec catdoc -a $fichier
}


# images {{{1

[[ $type_fichier = *:*(PNG|JPEG|GIF)*image* ]] && {

	echo "exec exiv2 pr $fichier"
	echo

	#exec identify -verbose $fichier

	exec exiv2 pr $fichier
}

# tar.gzip {{{1

[[ $fichier = *.tar.gz ]] && {

	echo "exec tar tzvf $fichier"
	echo

	exec tar tzvf $fichier
}


# tar.bzip {{{1

[[ $type_fichier = *:*tar*archive*bzip*compressed* ]] && {

	echo "exec tar tjvf $fichier"
	echo

	exec tar tjvf $fichier
}


# tar.lzma {{{1

[[ $fichier = *.(tar.lzma|tlz) ]] && {

	echo "exec tar tvf $fichier --lzma"
	echo

	exec tar tvf $fichier --lzma
}


# tar.xz {{{1

[[ $type_fichier = *:*tar*archive*XZ*compressed* ]] && {

	echo "exec tar tJvf $fichier"
	echo

	exec tar tJvf $fichier
}


# tar.zst {{{1

[[ $fichier = *.tar.zst ]] && {

	echo "exec tar tvf $fichier"
	echo

	exec tar tvf $fichier
}

# cpio.xz {{{1

[[ $fichier = *.cpio.xz ]] && {

	echo "exec xzcat $fichier | cpio -it"
	echo

	exec xzcat $fichier | cpio -it

	exit 0
}


# ar {{{1

[[ $type_fichier = *:*[^A-Za-z]ar*archive* ]] && {

	echo "exec ar tv $fichier"
	echo

	exec ar tv $fichier
}


# tar {{{1

[[ $type_fichier = *:*tar*archive* ]] && {

	echo "exec tar tvf $fichier"
	echo

	exec tar tvf $fichier
}


# cpio {{{1

[[ $type_fichier = *:*cpio*archive* ]] && {

	echo "exec cpio -it < $fichier"
	echo

	exec cpio -it < $fichier
}


# pax {{{1

[[ $fichier = *.pax ]] && {

	echo "exec pax < $fichier"
	echo

	exec pax < $fichier
}


# gzip {{{1

[[ $type_fichier = *:*gzip*compressed* ]] && {

	echo "exec zcat $fichier"
	echo

	exec zcat $fichier
}

# bzip {{{1

[[ $type_fichier = *:*bzip*compressed* ]] && {

	echo "exec bzcat $fichier"
	echo

	exec bzcat $fichier
}

# lzma {{{1

[[ $type_fichier = *:*LZMA*compressed* ]] && {

	echo "exec lzcat $fichier"
	echo

	exec lzcat $fichier
}

# xz {{{1

[[ $type_fichier = *:*XZ*compressed* ]] && {

	echo "exec xzcat $fichier"
	echo

	exec xzcat $fichier
}


# zst {{{1

[[ $type_fichier = *:*Zstandard*compressed* ]] && {

	echo "exec zstdcat $fichier"
	echo

	exec zstdcat $fichier
}

# zip & dérivés {{{1

[[ $type_fichier = *:*Zip*archive* ]] && {

	echo "exec zipinfo $fichier"
	echo

	exec zipinfo $fichier
}

# 7z {{{1

[[ $type_fichier = *:*7-zip*archive* ]] && {

	echo "exec 7z l $fichier"
	echo

	exec 7z l $fichier
}


# Z (compress) {{{1

[[ $fichier = *.Z ]] && {

	echo "exec uncompress -c $fichier"
	echo

	exec uncompress -c $fichier
}

# rar {{{1

[[ $fichier = *.rar ]] && {

	echo "exec unrar -l $fichier"
	echo

	exec unrar -l $fichier
}


# flac {{{1

[[ $type_fichier = *:*FLAC*audio* ]] && {

	echo "exec metaflac --list $fichier"
	echo

	exec metaflac --list $fichier
}


# jar {{{1

[[ $fichier = *.jar ]] && {

	echo "exec fastjar -x $fichier"
	echo

	exec fastjar -x $fichier
}


# ogg / vorbis {{{1

[[ $type_fichier = *:*Ogg*Vorbis*audio* ]] && {

	echo "exec ogginfo $fichier"
	echo

	exec ogginfo $fichier
}


# mp3 {{{1

[[ $type_fichier = *:*MPEG*ADTS*layer*III* ]] && {

	echo "exec mediainfo $fichier"
	echo

	exec mediainfo $fichier

# 	echo "exec mp3info -x $fichier"
# 	echo
#
# 	exec mp3info -x $fichier

}


# matroska {{{1

[[ $type_fichier = *:*Matroska* ]] && {

	echo "mkvmerge -i $fichier"
	echo

	mkvmerge -i $fichier

	echo
	echo "exec mkvinfo $fichier"
	echo

	exec mkvinfo $fichier
}

# emacs byte-compiled {{{1

[[ $type_fichier = *:*Emacs*byte-compiled* ]] && {

	chaine=$(strings -tx -n 4 $fichier)

	[[ $#chaine > 0 ]] && {

		echo
		echo "strings -tx -n 4 $fichier"
		echo

		echo $chaine
	}

	echo
	echo "exec hexdump -C $fichier"
	echo

	exec hexdump -C $fichier
}

# berkeley DB {{{1

[[ $type_fichier = *:*Berkeley*DB* ]] && {

	chaine=$(strings -tx -n 4 $fichier)

	[[ $#chaine > 0 ]] && {

		echo
		echo "strings -tx -n 4 $fichier"
		echo

		echo $chaine
	}

	echo
	echo "exec hexdump -C $fichier"
	echo

	exec hexdump -C $fichier
}

# ID utils {{{1

[[ $type_fichier = *:*ID*tags*data* ]] && {

	chaine=$(strings -tx -n 4 $fichier)

	[[ $#chaine > 0 ]] && {

		echo
		echo "strings -tx -n 4 $fichier"
		echo

		echo $chaine
	}

	echo
	echo "exec hexdump -C $fichier"
	echo

	exec hexdump -C $fichier
}

# binaires {{{1

[[ $type_fichier = *:*ELF*executable* ]] && {

	echo "ldd $fichier"
	echo

	ldd $fichier

	echo
	echo "readelf -d $fichier"
	echo

	readelf -d $fichier

	echo
	echo "readelf -h $fichier"
	echo

	readelf -h $fichier

	chaine=$(strings -tx -n 4 $fichier)

	[[ $#chaine > 0 ]] && {

		echo
		echo "strings -tx -n 4 $fichier"
		echo

		echo $chaine
	}

	echo
	echo "exec hexdump -C $fichier"
	echo

	exec hexdump -C $fichier
}

# data {{{1

[[ $type_fichier = *:*data* ]] && {

	chaine=$(strings -tx -n 4 $fichier)

	[[ $#chaine > 0 ]] && {

		echo
		echo "strings -tx -n 4 $fichier"
		echo

		echo $chaine
	}

	echo
	echo "exec hexdump -C $fichier"
	echo

	exec hexdump -C $fichier
}

# empty {{{1

[[ $type_fichier = *:*empty* ]] && {

	echo "Lesspipe : $fichier is empty" >&2

	exit 0
}

# plain text {{{1

[[ $type_fichier = *:*text* ]] && {

	#cat $fichier

	# LESSOPEN commence par "||" :
	# fichier de départ utilisé si code de retour > 0

	exit 1
}

# indéfini {{{1

echo 'Could not find an adequate filetype' >&2
echo >&2
