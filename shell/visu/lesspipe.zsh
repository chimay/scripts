#! /usr/bin/env zsh

# {{{ Options

emulate -R zsh

setopt extended_glob

setopt clobber

# }}}

# {{{ Documentation

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

# }}}

export PROFONDEUR=${PROFONDEUR:-0}

(( PROFONDEUR += 1 ))

fichier=$1

type_fichier=$(file -L -z $fichier) || type_fichier=$(file -L $fichier)

# {{{ Non existant

[[ -e $fichier ]] || {

	echo "Le fichier $fichier n’existe pas." >& 2
	echo >& 2

	exit 1
}

# }}}

# {{{ Liens symboliques

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

# }}}

# {{{ Répertoire

[[ -d $fichier ]] && {

	echo "exec tree -C -A $fichier"
	echo

	exec tree -C -A $fichier
}

# }}}

# {{{ PDF

[[ $type_fichier = *:*PDF* ]] && {

	echo "exec pdftotext $fichier -"
	echo

	exec pdftotext $fichier -
}

# }}}

# {{{ PDF compressed with XZ

[[ $fichier = *.pdf.xz ]] && {

	# Ne fonctionne pas

	echo "exec pdftotext <(xz -dc $fichier) -"
	echo

	exec pdftotext <(xz -dc $fichier) -
}

# }}}

# {{{ Html

[[ $fichier = *.html ]] && {

	echo "exec w3m -dump $fichier"
	echo

	exec w3m -dump $fichier
}

# }}}

# {{{ OpenDocument

[[ $type_fichier = *:*OpenDocument* ]] && {

	echo "exec odt2txt $fichier"
	echo

	exec odt2txt $fichier
}

# }}}

# {{{ Word

[[ $fichier = *.doc ]] && {

	echo "exec antiword $fichier"
	echo

	exec antiword $fichier
}

# }}}

# {{{ Docx

[[ $fichier = *.docx ]] && {

	echo "exec docx2txt $fichier -"
	echo

	exec docx2txt $fichier -
}

# }}}

#  {{{ RTF

[[ $fichier = *.rtf ]] && {

	echo "exec catdoc -a $fichier"
	echo

	exec catdoc -a $fichier
}

#  }}}

# {{{ Images

[[ $type_fichier = *:*(PNG|JPEG|GIF)*image* ]] && {

	echo "exec exiv2 pr $fichier"
	echo

	#exec identify -verbose $fichier

	exec exiv2 pr $fichier
}

# }}}

# {{{ Tar.gzip

[[ $fichier = *.tar.gz ]] && {

	echo "exec tar tzvf $fichier"
	echo

	exec tar tzvf $fichier
}

# }}}

# {{{ Tar.bzip

[[ $type_fichier = *:*tar*archive*bzip*compressed* ]] && {

	echo "exec tar tjvf $fichier"
	echo

	exec tar tjvf $fichier
}

# }}}

# {{{ Tar.lzma

[[ $fichier = *.(tar.lzma|tlz) ]] && {

	echo "exec tar tvf $fichier --lzma"
	echo

	exec tar tvf $fichier --lzma
}

# }}}

# {{{ Tar.xz

[[ $type_fichier = *:*tar*archive*XZ*compressed* ]] && {

	echo "exec tar tJvf $fichier"
	echo

	exec tar tJvf $fichier
}

# }}}

# {{{ Tar.zst

[[ $fichier = *.tar.zst ]] && {

	echo "exec tar tvf $fichier"
	echo

	exec tar tvf $fichier
}

# }}}

# {{{ Cpio.xz

[[ $fichier = *.cpio.xz ]] && {

	echo "exec xzcat $fichier | cpio -it"
	echo

	exec xzcat $fichier | cpio -it

	exit 0
}

# }}}

# {{{ Ar

[[ $type_fichier = *:*[^A-Za-z]ar*archive* ]] && {

	echo "exec ar tv $fichier"
	echo

	exec ar tv $fichier
}

# }}}

# {{{ Tar

[[ $type_fichier = *:*tar*archive* ]] && {

	echo "exec tar tvf $fichier"
	echo

	exec tar tvf $fichier
}

# }}}

# {{{ Cpio

[[ $type_fichier = *:*cpio*archive* ]] && {

	echo "exec cpio -it < $fichier"
	echo

	exec cpio -it < $fichier
}

# }}}

# {{{ Pax

[[ $fichier = *.pax ]] && {

	echo "exec pax < $fichier"
	echo

	exec pax < $fichier
}

# }}}

# {{{ Gzip

[[ $type_fichier = *:*gzip*compressed* ]] && {

	echo "exec zcat $fichier"
	echo

	exec zcat $fichier
}

# }}}

# {{{ Bzip

[[ $type_fichier = *:*bzip*compressed* ]] && {

	echo "exec bzcat $fichier"
	echo

	exec bzcat $fichier
}

# }}}

# {{{ Lzma

[[ $type_fichier = *:*LZMA*compressed* ]] && {

	echo "exec lzcat $fichier"
	echo

	exec lzcat $fichier
}

# }}}

# {{{ Xz

[[ $type_fichier = *:*XZ*compressed* ]] && {

	echo "exec xzcat $fichier"
	echo

	exec xzcat $fichier
}

# }}}

# {{{ Zip & dérivés

[[ $type_fichier = *:*Zip*archive* ]] && {

	echo "exec zipinfo $fichier"
	echo

	exec zipinfo $fichier
}

# }}}

# {{{ 7z

[[ $type_fichier = *:*7-zip*archive* ]] && {

	echo "exec 7z l $fichier"
	echo

	exec 7z l $fichier
}

# }}}

# {{{ Z (compress)

[[ $fichier = *.Z ]] && {

	echo "exec uncompress -c $fichier"
	echo

	exec uncompress -c $fichier
}

# }}}

# {{{ RAR

[[ $fichier = *.rar ]] && {

	echo "exec unrar -l $fichier"
	echo

	exec unrar -l $fichier
}

# }}}

# {{{ FLAC

[[ $type_fichier = *:*FLAC*audio* ]] && {

	echo "exec metaflac --list $fichier"
	echo

	exec metaflac --list $fichier
}

# }}}

# {{{ JAR

[[ $fichier = *.jar ]] && {

	echo "exec fastjar -x $fichier"
	echo

	exec fastjar -x $fichier
}

# }}}

# {{{ OGG / VORBIS

[[ $type_fichier = *:*Ogg*Vorbis*audio* ]] && {

	echo "exec ogginfo $fichier"
	echo

	exec ogginfo $fichier
}

# }}}

# {{{ MP3

[[ $type_fichier = *:*MPEG*ADTS*layer*III* ]] && {

	echo "exec mediainfo $fichier"
	echo

	exec mediainfo $fichier

# 	echo "exec mp3info -x $fichier"
# 	echo
#
# 	exec mp3info -x $fichier

}

# }}}

# {{{ Matroska

[[ $type_fichier = *:*Matroska* ]] && {

	echo "mkvmerge -i $fichier"
	echo

	mkvmerge -i $fichier

	echo
	echo "exec mkvinfo $fichier"
	echo

	exec mkvinfo $fichier
}

# }}}

# {{{ Emacs byte-compiled

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

# }}}

# {{{ Berkeley DB

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

# }}}

# {{{ ID utils

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

# }}}

# {{{ Binaires

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

# }}}

# {{{ Data

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

# }}}

# {{{ Empty

[[ $type_fichier = *:*empty* ]] && {

	echo "Lesspipe : $fichier is empty" >&2

	exit 0
}

# }}}

# {{{ Plain text

[[ $type_fichier = *:*text* ]] && {

	#cat $fichier

	# LESSOPEN commence par "||" :
	# fichier de départ utilisé si code de retour > 0

	exit 1
}

# }}}

# {{{ Indéfini

echo 'Could not find an adequate filetype' >&2
echo >&2

# }}}
