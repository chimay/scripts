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

# Initialisation {{{1

float dispersion=1

principal=$HOME/racine/pictura/list/wallpaper.meta

prereper=$PWD

filtre='(.)'

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

# Scores {{{1

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

# for key val in ${(kv)scores}; do
#     echo "$key -> $val"
# done

# }}}1

# Lecture meta {{{1

metafile=`basename $principal`
metadir=`dirname $principal`

echo "Meta file : $metafile"
echo "Meta dir  : $metadir"
echo
echo "cd $metadir"
echo

cd $metadir

metaroot=$(grep '^root' $metafile | cut -d ' ' -f 2)
metaroot=$~metaroot
[ -z $metaroot ] && metaroot=$prereper

echo Metaroot : $metaroot
echo

meta=($metafile)
while read ligne
do
	case $ligne in
		inc*|incl*|inclu*|includ*|include)
			meta+=${ligne##* }
			;;
	esac
done < $metafile

echo Meta
echo '----'
print -l $meta
echo

glob=()
ignore=()
force=()

for fichier in $meta
do
	racine=$(grep '^root' $fichier | cut -d ' ' -f 2)
	[ -z $racine ] && racine=$metaroot
	racine=$~racine

	echo "Fichier : $fichier"
	echo "Racine  : $racine"
	echo

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

echo Glob
echo '----'
print -l $glob
echo

echo Ignore
echo '------'
print -l $ignore
echo

echo Force
echo '-----'
print -l $force
echo

# }}}1

# Conversion glob -> fichiers {{{1

liste=()

for motif in $glob
do
	liste+=($~motif)
done

liste=(${(ou)liste})

echo Liste
echo '-----'
print -l $liste
echo

for motif in $ignore
do
	soustraction+=($~motif)
done

soustraction=(${(ou)soustraction})

echo Soustraction
echo '------------'
print -l $soustraction
echo

liste=($(comm -23 <(print -l $liste) <(print -l $soustraction) ))

echo Liste après soustraction
echo '------------------------'
print -l $liste
echo

for motif in $force
do
	liste+=($~motif)
done

liste=(${(ou)liste})

echo Liste après addition
echo '------------------------'
print -l $liste
echo

# }}}1
