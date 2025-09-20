#!/usr/bin/env zsh

# vim: set filetype=zsh:

# Options {{{1

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

setopt null_glob
unsetopt case_glob

#zmodload -i zsh/mathfunc

#zmodload zsh/regex

# Fonctions {{{1

echoerr () {
	print "$@" >&2
}

echoerr-lignes () {
	print -l "$@" >&2
}

# Initialisation {{{1

dispersion=5

principal=$HOME/racine/pictura/list/wallpaper.meta

prereper=$PWD

filtre='(.)'

# Affichage {{{1

echoerr "=========================================="
echoerr " " $(date +"%H : %M %A %d %B %Y")
echoerr "=========================================="
echoerr

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

# Arguments {{{1

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

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "$(basename $0) : generate shuffled file list"
	echo "                      with [0-9A-Z]-* priorities in filenames"
	echo
	echo "Dependancies : random.zsh"
	echo
	echo "Usage: $(basename $0) dispersion main-meta-file"
	echo
	echo "[Meta file format]"
	echo
	echo "root <basedir>      : evaluate glob patterns from <basedir>"
	echo "                      if no root directory is found in main meta file,"
	echo "                      current directory will be used"
	echo "<folder>            : recursively add all files of <folder> in list"
	echo "fold[er] <folder>   : same as above"
	echo
	echo "glob <glob>         : add all files matching glob"
	echo "file <name>         : add all files whose exact name is <name>"
	echo "match <string>      : add all files/dirs containing <string>"
	echo "match-file <string> : add all files containing <string>"
	echo "match-dir <string>  : add all dirs containing <string>"
	echo
	echo "ign[ore] <glob>     : remove all files matching <glob>"
	echo "not-file <name>     : remove all files whose exact name is <name>"
	echo "ban <string>        : remove all files/dirs containing <string>"
	echo "ban-file <string>   : remove all files containing <string>"
	echo "ban-dir <string>    : remove all dirs containing <string>"
	echo "force <glob>        : add all files matching <glob>, even if present"
	echo "                      in ignore or ban directive"
	echo "inc[lude] <file>    : include another meta <file>"
	echo "                      to prevent infinite loops, include directives"
	echo "                      in included files are ignored"
	echo "# <comment>         : lines beginning with a # are ignored"
	echo
	echo "[Globbing]"
	echo
	echo "Glob patterns are interpreted as zsh style."
	echo
	echo "In case of a ** ending pattern, a final /* will be added."
	echo "Example : ** -> **/*"
	echo
	echo "[Priorities]"
	echo
	echo "You can add a priority to a file by using the name format :"
	echo "    [0-9A-Z]-*"
	echo "The highest priority is 0, and the lowest is Z."
	echo
	echo "Example : 0-foo will have more chance to be at the top of the list,"
	echo "and Z-bar will tend to be at the bottom."
	echo
	echo "So, with a null dispersion, you will have a shuffled list"
	echo "which looks like :"
	echo "    0-* 1-* ... 9-* A-* B-* ... Z-*"
	echo "The more you raise the dispersion, the more shuffled priorities will be."
	exit 0
}

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

metalist=($metafile)
while read ligne
do
	case $ligne in
		inc*|incl*|inclu*|includ*|include)
			metalist+=${ligne##* }
			;;
	esac
done < $metafile

echoerr '[Metas]'
echoerr
echoerr-lignes $metalist
echoerr

glob=()
ignore=()
force=()

for fichier in $metalist
do
	racine=$(grep '^root' $fichier | cut -d ' ' -f 2)
	[ -z $racine ] && racine=$metaroot
	racine=$~racine

	echoerr "File : $fichier"
	echoerr "Root  : $racine"
	echoerr

	while read ligne
	do
		case $ligne in
			\#*|root\ *|include\ *)
				:
				;;
			glob\ *)
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
			file\ *)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/**/$motif
				fi
				glob+=$motif
				;;
			match\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				glob+=$motif
				motif=${ligne##* }
				motif=$racine/**/*$motif*/**/*$filtre
				glob+=$motif
				;;
			match-file\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				glob+=$motif
				;;
			match-dir\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*/**/*$filtre
				glob+=$motif
				;;
			ign\ *|igno\ *|ignor\ *|ignore\ *)
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
			not-file\ *)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/**/$motif
				fi
				ignore+=$motif
				;;
			ban\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				ignore+=$motif
				motif=${ligne##* }
				motif=$racine/**/*$motif*/**/*$filtre
				ignore+=$motif
				;;
			ban-file\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*$filtre
				ignore+=$motif
				;;
			ban-dir\ *)
				motif=${ligne##* }
				motif=$racine/**/*$motif*/**/*$filtre
				ignore+=$motif
				;;
			force\ *)
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
			?*|fol\ *|fold\ *|folde\ *|folder\ *)
				motif=${ligne##* }
				if ! [ $motif[1] = / -o $motif[1] = \~ ]
				then
					motif=$racine/**/$motif/**/*$filtre
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

# Conversion glob -> fichiers {{{1

echoerr Glob pattern conversion
echoerr

liste=()

for motif in $glob
do
	liste+=($~motif)
done

liste=(${(ou)liste})

# echoerr List
# echoerr
# echoerr-lignes $liste
# echoerr

for motif in $ignore
do
	soustraction+=($~motif)
done

soustraction=(${(ou)soustraction})

# echoerr Substraction
# echoerr
# echoerr-lignes $soustraction
# echoerr

liste=($(comm -23 <(print -l $liste) <(print -l $soustraction) ))

# echoerr List after substraction
# echoerr
# echoerr-lignes $liste
# echoerr

for motif in $force
do
	liste+=($~motif)
done

liste=(${(ou)liste})

# echoerr List after addition
# echoerr
# echoerr-lignes $liste
# echoerr

# Nombres aléatoires {{{1

echoerr Random numbers generation
echoerr

alea=($(random.zsh 0.0 $dispersion $#liste))

# Tri de la liste {{{1

echoerr Sorting list
echoerr

complet=${principal/.?*/.score}
[[ $complet = $principal ]] && complet=${complet}.score

genere=${principal/.?*/.m3u}
[[ $genere = $principal ]] && genere=${genere}.m3u

echoerr "List with score : $complet"
echoerr "List            : $genere"
echoerr

rm -f $complet $genere

ind=1

for fichier in $liste
do
	base=${fichier##*/}
	if [ $#base -lt 2 ]
	then
		valeur=$scoreParDefaut
	elif [ $base[2] = - ]
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
