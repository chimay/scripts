#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

setopt null_glob
unsetopt case_glob

#zmodload -i zsh/mathfunc

#zmodload zsh/regex

# }}}

# Fonctions {{{1

echoerr () {
	print "$@" >&2
}

echoerr-lignes () {
	print -l "$@" >&2
}

# }}}1

# Initialisation {{{1

dispersion=5

principal=$HOME/racine/pictura/list/wallpaper.meta

complet=${principal/.?*/.score}
genere=${principal/.?*/.m3u}

prereper=$PWD

filtre='(.)'

# }}}1

# Affichage {{{1

echoerr "=========================================="
echoerr " " $(date +"%H : %M %A %d %B %Y")
echoerr "=========================================="
echoerr

# }}}1

# Scores {{{1

scoreParDefaut=-1

typeset -A scores

integer note=31

for char in {0..9} {a..u}
do
	(( note -= 1 ))
	scores[$char]=$note
done

for char in {v..z}
do
	(( note -= 100 ))
	scores[$char]=$note
done

note=21

for char in {A..U}
do
	(( note -= 1 ))
	scores[$char]=$note
done

for char in {V..Z}
do
	(( note -= 100 ))
	scores[$char]=$note
done

# echoerr '[Scores]'
# echoerr
# for key val in ${(kv)scores}; do
#     echoerr "$key -> $val"
# done
# echoerr

# }}}1

# {{{ Arguments

numarg=$#

aide=0

nombres=()
fanions=()
autres=()

while true
do
	case $1 in
		-h)
			aide=1
			shift
			;;
		[0-9.]##)
			nombres+=$1
			shift
			;;
		-*)
			fanions+=$1
			shift
			;;
		?*)
			autres+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

(( $#nombres > 0 )) && dispersion=$nombres[1]
(( $#autres > 0 )) && principal=$autres[1]

# }}}

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "$(basename $0) : generate shuffled file list"
	echo "                      with [0-9A-Z]-* priorities in filenames"
	echo
	echo "Usage: $(basename $0) dispersion main-meta-file"
	echo
	echo Meta file format
	echo
	echo "root <basedir>    : evaluate glob patterns from <basedir>"
	echo "                    if no root directory is found in main meta file,"
	echo "                    current directory will be used"
	echo "<folder>          : recursively add all files of <folder> in list"
	echo "fold[er] <folder> : same as above"
	echo "glob <glob>       : add all files matching glob"
	echo "match <string>    : add all files matching **/*<string>*"
	echo "ign[ore] <glob>   : remove all files matching <glob>"
	echo "ban <string>      : remove all files matching **/*<string>*"
	echo "force <glob>      : add all files matching **/*<glob>*, even if present"
	echo "                    in ignore or ban directive"
	echo "inc[lude] <file>  : include another meta <file>"
	echo "                    to prevent infinite loops, include directives"
	echo "                    in included files are ignored"
	echo "# <comment>       : lines beginning with a # are ignored"
	echo
	echo Globs
	echo
	echo "In case of a ** ending pattern, a final /* will be added."
	echo "Example : ** -> **/*"
	exit 0
}

# }}}1

# Lecture meta {{{1

metafile=`basename $principal`
metadir=`dirname $principal`

echoerr "Meta file : $metafile"
echoerr "Meta dir  : $metadir"
echoerr
echoerr "cd $metadir"
echoerr

cd $metadir

metaroot=$(grep '^root' $metafile | cut -d ' ' -f 2)
metaroot=$~metaroot
[ -z $metaroot ] && metaroot=$prereper

echoerr Metaroot : $metaroot
echoerr

meta=($metafile)
while read ligne
do
	case $ligne in
		inc*|incl*|inclu*|includ*|include)
			meta+=${ligne##* }
			;;
	esac
done < $metafile

echoerr '[Metas]'
echoerr
echoerr-lignes $meta
echoerr

glob=()
ignore=()
force=()

for fichier in $meta
do
	racine=$(grep '^root' $fichier | cut -d ' ' -f 2)
	[ -z $racine ] && racine=$metaroot
	racine=$~racine

	echoerr "Fichier : $fichier"
	echoerr "Racine  : $racine"
	echoerr

	while read ligne
	do
		case $ligne in
			\#*|root*|include*)
				:
				;;
			glob*)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/$motif
				fi
				if [ $motif[-2,-1] = '**' ]
				then
					motif=$motif/*$filtre
				fi
				glob+=$motif
				;;
			match*)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				glob+=$motif
				;;
			ign*|igno*|ignor*|ignore*)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/$motif
				fi
				if [ $motif[-2,-1] = '**' ]
				then
					motif=$motif/*$filtre
				fi
				ignore+=$motif
				;;
			ban*)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				ignore+=$motif
				;;
			force*)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/$motif
				fi
				if [ $motif[-2,-1] = '**' ]
				then
					motif=$motif/*$filtre
				fi
				force+=$motif
				;;
			?*|fol*|fold*|folde*|folder*)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/$motif/**/*$filtre
				else
					motif=$motif/**/*$filtre
				fi
				glob+=$motif
				;;
		esac
	done < $fichier
done

echoerr '[Glob]'
echoerr
echoerr-lignes $glob
echoerr

echoerr '[Ignore]'
echoerr
echoerr-lignes $ignore
echoerr

echoerr '[Force]'
echoerr
echoerr-lignes $force
echoerr

# }}}1

# Conversion glob -> fichiers {{{1

echoerr Conversion des motifs glob
echoerr

liste=()

for motif in $glob
do
	liste+=($~motif)
done

liste=(${(ou)liste})

# echoerr Liste
# echoerr
# echoerr-lignes $liste
# echoerr

for motif in $ignore
do
	soustraction+=($~motif)
done

soustraction=(${(ou)soustraction})

# echoerr Soustraction
# echoerr
# echoerr-lignes $soustraction
# echoerr

liste=($(comm -23 <(print -l $liste) <(print -l $soustraction) ))

# echoerr Liste après soustraction
# echoerr
# echoerr-lignes $liste
# echoerr

for motif in $force
do
	liste+=($~motif)
done

liste=(${(ou)liste})

# echoerr Liste après addition
# echoerr
# echoerr-lignes $liste
# echoerr

# }}}1

# Nombres aléatoires {{{1

echoerr Génération des nombres aléatoires
echoerr

alea=($(random.zsh 0.0 $dispersion $#liste))

# }}}1

# Tri de la liste {{{1

echoerr Tri de la liste
echoerr

rm -f $complet $genere

ind=1

for fichier in $liste
do
	base=${fichier##*/}
	if [ $base[2] = - ]
	then
		caractere=$base[1]
		valeur=$scores[$caractere]
	else
		valeur=$scoreParDefaut
	fi
	(( valeur += alea[ind] ))
	(( ind += 1 ))
	echo "$valeur $fichier"
done | sort -k 1,1 -gr > $complet

cut -d ' ' -f 2 $complet > $genere

# }}}1
