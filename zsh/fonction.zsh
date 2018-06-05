# vim: set ft=zsh :

# Autoload {{{1

# Voir aussi <url:~/racine/config/cmdline/zsh/zshenv#tn=Fonctions>

# Pour recompiler :
# voir make dans
# ~/racine/dotdir/zsh/autoload/Makefile

for fichier in ~/racine/fun/zsh/autoload/*/*(.:t)
do
	autoload $fichier
done

# }}}1

# Fonctions ordinaires {{{1

# err : display to stderr {{{2

err () {

	print "$@" 1>&2
}

# }}}2

# x : échange des noms de fichiers {{{2

x () {
	(( $# < 2 )) && {
		echo "Usage : x <file-1> <file 2>"
		echo
		return 1
	}

	local TMPFILE=tmp-$1-$2.$$

	mv "$1" $TMPFILE

	mv "$2" "$1"

	mv $TMPFILE "$2"
}

# }}}2

# nf : nombre-de-fichiers {{{2

nf () {
	local arguments
	local repertoire

	if (( $# == 0 ))
	then
		arguments=.
	else
		arguments=($@)
	fi

	for repertoire in $arguments
	do
		[[ -d $repertoire ]] || continue

		echo "`print -l ${repertoire}/**/*(.) | wc -l` : $repertoire"
	done
}

# }}}2

# mrm : most recent modified files {{{2

mrm () {

	command ls -lht "$@" | command head -n 15
}

# }}}2

# search-grep {{{2

search-grep () {

	local motif fichiers

	motif=${1:-''}

	(( $# > 0 )) && shift

	fichiers=(${*:-()})

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	(( $#fichiers > 0 )) || fichiers=(**/*(.))

	command grep --color=never $motif $=fichiers | sed 's/^/  /'
}

# }}}2

# search-ag {{{2

search-ag () {

	local motif fichiers

	motif=${1:-''}

	(( $# > 0 )) && shift

	fichiers=(${*:-()})

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	(( $#fichiers > 0 )) || fichiers=(.)

	command ag --nocolor --vimgrep --smart-case $motif $=fichiers | sed 's/^/  /'
}

# }}}2

# find-command {{{2

grep-command () {
	print -l $commands | command grep "$@"
}

# }}}2

# lc : locate {{{2

lc () {
	local options mots dossier motifs

	options=()
	mots=()

	while true
	do
		case $1 in
			-*)
				options+=$1
				shift
				;;
			?*)
				mots+=$1
				shift
				;;
			*)
				break
				;;
		esac
	done

	if (( $#mots >= 2 ))
	then
		dossier=$mots[1]
		motifs=$mots[2,-1]

	elif (( $#mots == 1 ))
	then
		dossier=racine
		motifs=$mots
	fi

	case $dossier in

		r|ra|rac|raci|racin|racine)
			echo "locate -d ~/racine/index/locate/racine.db -e -A $=options $=motifs"
			echo
			locate -d ~/racine/index/locate/racine.db -e -A $=options $=motifs
			;;
		ul|ulo|uloc|usrloc|usrlocal)
			echo "locate -d ~/racine/index/locate/usr-local.db -e -A $=options $=motifs"
			echo
			locate -d ~/racine/index/locate/usr-local.db -e -A $=options $=motifs
			;;
		p|pa|pac|pacman|pacmanlib)
			echo "locate -d ~/racine/index/locate/pacman-lib.db -e -A $=options $=motifs"
			echo
			locate -d ~/racine/index/locate/pacman-lib.db -e -A $=options $=motifs
			;;
		a|au|aud|audi|audio)
			echo "locate -d ~/racine/index/locate/audio.db -e -A $=options $=motifs"
			echo
			locate -d ~/racine/index/locate/audio.db -e -A $=options $=motifs
			;;
		f|ph|pho|phot|photo)
			echo "locate -d ~/racine/index/locate/photo.db -e -A $=options $=motifs"
			echo
			locate -d ~/racine/index/locate/photo.db -e -A $=options $=motifs
			;;
	esac
}

# }}}2

# pg : process grep {{{2

pg () {

	local motif

	motif="$@"

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	command ps --no-headers -eo '%p %a' | command grep -v grep | command grep --color=never $motif
}

# }}}2

# pid : grep process id(s) {{{2

pid () {

	local motif

	motif="$@"

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	command ps --no-headers -eo '%p %a' | \
		command grep -v grep | \
		command grep --color=never $motif | \
		awk '{print $1}'
}


# }}}2

# psi : process signal {{{2

psi () {

	local motif identifiants reponse signal

	motif="$@"

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	reponse=n

	command ps --no-headers -eo '%p %a' | command grep -v grep | command grep --color=never $motif
	echo

	identifiants=($(
		command ps --no-headers -eo '%p %a' |
		command grep -v grep |
		command grep --color=never $motif |
		awk '{print $1}'
	))

	echo $=identifiants
	echo

	(( $#identifiants > 0 )) || return 2

	echo -n "Voulez-vous envoyer un signal à ces processus ? (y/n, o/n) "
	read reponse
	echo

	(( $#reponse > 0 )) || return 1

	[ $reponse = y -o $reponse = o -o $reponse = yes -o $reponse = oui ] || return 0

	echo -n "Signal [1 = TERM] (l=liste des signaux) : "
	read signal
	echo

	(( $#signal == 0 )) && signal=1

	while [ $signal = l ]
	do
		echo "Signal		Valeur	Action	Commentaire"
		echo "-----------------------------------------"
		echo "HUP        1       Term    Hangup detected on controlling terminal or death of controlling process"
		echo "INT        2       Term    Interrupt from keyboard"
		echo "QUIT       3       Core    Quit from keyboard"
		echo "ILL        4       Core    Illegal Instruction"
		echo "ABRT       6       Core    Abort signal from abort(3)"
		echo "FPE        8       Core    Floating-point exception"
		echo "KILL       9       Term    Kill signal"
		echo "SEGV      11       Core    Invalid memory reference"
		echo "PIPE      13       Term    Broken pipe: write to pipe with no readers; see pipe(7)"
		echo "ALRM      14       Term    Timer signal from alarm(2)"
		echo "TERM      15       Term    Termination signal"
		echo "USR1   30,10,16    Term    User-defined signal 1"
		echo "USR2   31,12,17    Term    User-defined signal 2"
		echo "CHLD   20,17,18    Ign     Child stopped or terminated"
		echo "CONT   19,18,25    Cont    Continue if stopped"
		echo "STOP   17,19,23    Stop    Stop process"
		echo "TSTP   18,20,24    Stop    Stop typed at terminal"
		echo "TTIN   21,21,26    Stop    Terminal input for background process"
		echo "TTOU   22,22,27    Stop    Terminal output for background process"
		echo

		echo -n "Signal [1 = TERM] (l=liste des signaux) : "
		read signal
		echo

		(( $#signal == 0 )) && signal=1
	done


	echo "kill -$signal $=identifiants"
	echo

	kill -$signal $=identifiants

}

# }}}2

# pgroup : groupe d’un processus {{{2

pgroup () {

	local motif listiden iden groupe arbre

	motif="$@"

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	listiden=($(
		command ps --no-headers -eo '%p %a' |
		command grep -v grep |
		command grep --color=never $motif |
		awk '{print $1}'
	))

	for iden in $=listiden
	do
		groupe=$(ps --no-headers -o "%r" -p $iden | tr -d ' \t\n\r')

		arbre=($(
			ps -eo "%r %p" |
			awk '{ if ( $1 == '$groupe' ) print $2 }'
		))

		echo "Groupe de $iden : $groupe"
		echo "------------------------------"
		echo
		command ps -o "%r %p %a" -p $=arbre
		echo
	done
}

# }}}2

# ptree : arbre du groupe d’un processus {{{2

ptree () {

	local motif listiden iden listgroupes groupe
	local parent enfant racine

	motif="$@"

	(( $#motif > 0 )) || {

		echo -n "Motif : "
		read motif
		echo
	}

	(( $#motif > 0 )) || return 1

	listiden=($(
		command ps --no-headers -eo '%p %a' |
		command grep -v grep |
		command grep --color=never $motif |
		awk '{print $1}'
	))

	listgroupes=()

	typeset -A grpiden

	for iden in $=listiden
	do
		groupe=$(ps --no-headers -o "%r" -p $iden | tr -d ' \t\n\r')
		listgroupes+=$groupe
		grpiden[$groupe]=$iden
	done

	listgroupes=(${(u)listgroupes})

	for groupe in $=listgroupes
	do
		enfant=$grpiden[$groupe]

		while true
		do
			parent=$( \
				ps -eo "%r %P %p" | \
				awk '{ if ( $1 == '$groupe' && $3 == '$enfant' ) print $2 }' \
			)

			echo "$parent -> $enfant"
			echo

			if (( $#parent > 0 ))
			then
				enfant=$parent
				racine=$parent
			else
				break
			fi
		done

		echo Racine : $racine
		echo

		pstree -p $racine
		echo
		ps -eo "%r %p %a" --forest | awk '{ if ( $1 == '$groupe' ) print $0 }'
	done

}

# }}}2

# pageur {{{2

pageur () {
	local less

	less="less --lesskey-file=$HOME/racine/built/less/key.out"

	(( $# == 0 )) && {

		$=less .

		return 0
	}

	$=less "$@"
}

# }}}2

# vf : vim quick fix {{{2

vf () {
	vim +cope -q <(ag --no-color --vimgrep --smart-case "$@")
}

# }}}2

# ssh {{{2

ssh() {

	local options mots
	local code=0
	local ancien
	local nom

	options=()

	while true
	do
		case $1 in
			-*)
				options+=$1
				shift
				;;
			*)
				break
				;;
		esac
	done

	mots=("$@")

	nom=${mots[1]%.*}

	echo nom = $nom
	echo

	ancien=$(tmux display-message -p '#{window_name}')

	if [ $TERM = tmux -o $TERM = tmux-256color ]
	then
		tmux rename-window "$nom"

		echo "command ssh $=options $=mots"
		echo

		command ssh $=options $=mots

		code=$?

		tmux rename-window $ancien
    else
		echo "command ssh $=options $=mots"
		echo

		command ssh $=options $=mots

		code=$?
    fi

	return $code
}

# }}}2

# sshx : ssh -X pour lancer des apps X Window {{{2

sshx() {

	local options mots
	local code=0
	local ancien
	local nom

	options=()

	while true
	do
		case $1 in
			-*)
				options+=$1
				shift
				;;
			*)
				break
				;;
		esac
	done

	mots=("$@")

	nom=${mots[1]%.*}

	echo nom = $nom
	echo

	ancien=$(tmux display-message -p '#{window_name}')

	if [ $TERM = tmux -o $TERM = tmux-256color ]
	then
		tmux rename-window "$nom"

		echo "command ssh -X -C $=options $=mots"
		echo

		command ssh -X -C $=options $=mots

		code=$?

		tmux rename-window $ancien
    else
		echo "command ssh -X -C $=options $=mots"
		echo

		command ssh -X -C $=options $=mots

		code=$?
    fi

	return $code
}

# }}}2

# cmd-mplayer {{{2

cmd-mplayer () {

	echo $* > ~/racine/run/fifo/mplayer
}

# }}}2

# cmd-mpv {{{2

cmd-mpv () {

	echo $* > ~/racine/run/fifo/mpv
}

# }}}2

# }}}1

# Fonctions ZLE {{{1

# Copie et désactive région {{{2

copie-et-desactive-region() {

	zle copy-region-as-kill

	(( REGION_ACTIVE == 1 )) && REGION_ACTIVE=0
}

# }}}2

# }}}1

# Fonctions mathématiques {{{1

# Module {{{2

zmodload -i zsh/mathfunc

# }}}2

# Gaussienne {{{2

#function zmath_gauss () {

	#local x mu sigma

	#x=$1
	#mu=$2
	#sigma=$3
	#(( exp( - (x - mu) * (x - mu) / sigma ** 2 ) ))
#}

#functions -M gauss 3 3 zmath_gauss

# }}}2

# }}}1

# Crochets {{{1

# Chpwd {{{2

# Voir aussi
# <url:zshenv#tn=DIRSTACKSIZE>
# <url:zshrc#tn=REPERTOIRES_FICHIER>
# <url:zlogout>

typeset -ga chpwd_functions

chpwd () {

	print -l $PWD >>! $REPERTOIRES_FICHIER
}

# }}}2

# Periodic {{{2

typeset -ga period_functions

# Exécutée chaque $PERIOD secondes

periodic () {


}

# }}}2

# Precmd {{{2

typeset -ga precmd_functions

precmd () {

	case $TERM in
		xterm*)
			print -Pn "\e]0;%n@%m: %~\a"
			;;
	esac
}

# }}}2

# Preexec {{{2

typeset -ga preexec_functions

preexec () {

	echo
}

# }}}2

#  Zshaddhistory {{{2

typeset -ga zshaddhistory_functions

zshaddhistory () {

	emulate -R zsh

	setopt local_options

    local line=${1%%$'\n'}
    local cmd=${line%% *}
	local argts=${(j/ /)argv}

    [[ ${#line} -ge 1
        && ${cmd}   != (plouf|plou[gh])
		&& ${argts} != *tutututututu*
		&& ${argts} != *totototototo*
    ]]
}

# }}}2

# Zshexit {{{2

typeset -ga zshexit_functions

zshexit () {


}

# }}}2

# }}}1

# Special Widgets {{{1

function zle-line-init zle-keymap-select {

	if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} ))
	then
		printf '%s' "${terminfo[smkx]}"
	fi

    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}+"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# }}}1
