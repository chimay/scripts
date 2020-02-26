#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

#setopt null_glob

zmodload -i zsh/mathfunc

#zmodload zsh/regex

# }}}

# Initialisation {{{1

float moyenne=0.0
float ecart=1.0
integer taille=1

# }}}1

# {{{ Arguments

numarg=$#

aide=0
numhist=0

nombres=()
fanions=()
autres=()

while true
do
	case $1 in
		-h)
			aide=1
			;;
		-s)
			shift
			numhist=$1
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

(( $#nombres > 0 )) && moyenne=$nombres[1]
(( $#nombres > 1 )) && ecart=$nombres[2]
(( $#nombres > 2 )) && taille=$nombres[3]

# }}}

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "Usage: $(basename $0) mean deviation sample-size [options]"
	echo "\tOptions"
	echo "\t-s N : print summary : mean, std dev and histogram of size N"
	exit 0
}

# }}}1

# Fractions {{{1

float ind frac

fractions=()
complemen=()

for ind in {1..256}
do
	(( frac = 1 / ind ))
	fractions+=$frac
	complemen+=$(( 1 - $frac ))
done

# }}}1

# Fonctions {{{1

# Linéaire {{{2

lineaire () {

	local mu=${1:-0}
	local sigma=${2:-1}

	local alea
	local jauge

	(( alea = 2 * rand48() - 1 ))

	for ind in {1..$#fractions}
	do
		(( jauge < complemen[ind] )) && break
		(( alea += ind * (2 * rand48() - 1) ))
	done

	return $(( alea * sigma + mu ))
}

functions -M lineaire 0 2

# }}}2

# Puissances de 2 {{{2

exponen () {

	local mu=${1:-0}
	local sigma=${2:-1}

	local alea
	local jauge

	(( alea = 2 * rand48() - 1 ))

	for ind in 1 2 4 8 16 32 64 128 256
	do
		(( jauge < complemen[ind] )) && break
		(( alea += ind * (2 * rand48() - 1) ))
	done

	return $(( alea * sigma + mu ))
}

functions -M exponen 0 2

# }}}2

# Moyenne & Écart-type observés {{{2

moyenne-ecart () {
	local alea
	local moyenne=0
	local ecart=0
	for alea in $echantillon
	do
		(( moyenne += alea ))
	done
	(( moyenne /= $#echantillon ))
	for alea in $echantillon
	do
		(( ecart += (alea - moyenne) * (alea - moyenne) ))
	done
	(( ecart = sqrt(ecart/($#echantillon - 1)) ))
	echo "Moyenne : $moyenne"
	echo "Écart-type : $ecart"
	echo
}

# }}}2

# Histogramme {{{2

histogramme () {
	local num=${1:-7}
	local min=$echantillon[1]
	local max=min
	local alea
	for alea in $echantillon
	do
		(( alea > max )) && max=$alea
		(( alea < min )) && min=$alea
	done
	local epaisseur=$(( (max - min) / num ))
	local recipients=()
	local bac
	for ind in {1..$num}
	do
		recipients[ind]=0
	done
	for ind in {1..$#echantillon}
	do
		(( bac = ceil(($echantillon[ind] - min) / epaisseur) ))
		(( bac == 0 )) && bac=1
		(( recipients[bac] += 1 ))
	done
	local mineur majeur
	for ind in {1..$#recipients}
	do
		(( mineur = min + (ind - 1) * epaisseur ))
		(( majeur = mineur + epaisseur ))
		echo "$mineur\t-\t$majeur\t:\t$recipients[ind]"
	done
}

# }}}2

# }}}1

echantillon=()

for ind in {1..$taille}
do
	#echantillon+=$((lineaire(moyenne, ecart)))
	echantillon+=$((exponen(moyenne, ecart)))
done

if [ $numhist -gt 0 ]
then
	moyenne-ecart
	histogramme $numhist
else
	print -l $echantillon
fi
