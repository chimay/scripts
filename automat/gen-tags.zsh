#! /usr/bin/env zsh

#  {{{ Logiciels

# Exuberant ctags & etags, pas ceux installés avec emacs !

ctags='ctags -o tags'
etags='ctags -e -o TAGS'

# Gtags

fichiers=gtags.files

gtags='gtags -v -I'

#  }}}

#  {{{  Dossiers où générer des tags

dossiers=()

if (( $# > 0 ))
then
	dossiers=($*)
else
	dossiers+=(~/racine/artisan)
	dossiers+=(~/racine/automat)
	dossiers+=(~/racine/common)
	dossiers+=(~/racine/config/*(/))
	dossiers+=(~/racine/fun)
	dossiers+=(~/racine/litera)
	dossiers+=(~/racine/musica)
	dossiers+=(~/racine/organ)
	dossiers+=(~/racine/pictura)
	dossiers+=(~/racine/plain)
	dossiers+=(~/racine/refer)
	dossiers+=(~/racine/science)
	dossiers+=(~/racine/self)
	dossiers+=(~/racine/shell)
	dossiers+=(~/racine/site)
	dossiers+=(~/racine/snippet)
	dossiers+=(~/racine/system)
fi

#  }}}

#  {{{  Date & Heure

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

#  }}}

#  {{{  Boucle

for repertoire in $dossiers
do
	echo "  Tags : $repertoire"
	echo '____________________________________'
	echo

	cd $repertoire

	rm -f tags TAGS

	echo "$=ctags **/*(.)"
	echo

	$=ctags **/*(.)

	echo "$=etags **/*(.)"
	echo

	$=etags **/*(.)

# 	[[ -e $fichiers ]] && rm -f $fichiers

# 	print -l **/*(.) > $fichiers

# 	echo "$=gtags -f $fichiers"
# 	echo

# 	$=gtags -f $fichiers

	echo
done

#  }}}
