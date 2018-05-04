#! /usr/bin/env zsh

delai=${1:-30}

annee=$(date +%Y)

archdir=~/racine/mail/Archives/$annee

# Fonctions {{{1

# Boucle {{{2

boucle () {

	local boite archfile

	for boite in $@
	do
		archfile=$archdir/$boite-$annee

		echo "Archfile : $archfile"
		echo "--------------------"
		echo

		[ -e $archfile.xz ] && {

			echo "unxz $archfile.xz"
			echo

			unxz $archfile.xz
		}

		echo "archive-mail.zsh --no-compress $delai $boite"
		echo

		archive-mail.zsh --no-compress $delai $boite

		echo

		[ -e $archfile ] && {

			echo "xz $archfile"
			echo

			xz $archfile
		}
	done
}

# }}}2

# Boucle avec delete {{{2

boucle_efface () {

	local boite

	for boite in $@
	do
		echo "$boite"
		echo "--------------------"
		echo

		echo "archive-mail.zsh --delete $delai $boite"
		echo

		archive-mail.zsh --delete $delai $boite

		echo
	done
}

# }}}2

# }}}1

# Affichage prélude {{{1

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

echo
echo "======= Njours : $delai ======="
echo

# }}}1

# Système {{{1

cd ~/racine/mail/Systeme

liste=(Ajournes Envoyes Lus Reception mbox)

boucle $liste

# }}}1

# Thèmes {{{1

cd ~/racine/mail/Themes

liste=(Amis Comptes Ecole Emploi Famille Publicites)

boucle $liste

# }}}1

# Finance {{{1

cd Finance

liste=(Belgacom Binck Electrabel Zonebourse Zoomit)

boucle $liste

# }}}1

# Mailing lists {{{1

cd ~/racine/mail/Listes

liste=(Vim)

boucle $liste

# }}}1

# ------------------------------------------------------------

# Systeme : delete {{{1

cd ~/racine/mail/Systeme

liste=(Corbeille Doublons Pourriel)

boucle_efface $liste

# }}}1

echo
