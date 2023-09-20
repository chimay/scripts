#! /usr/bin/env zsh

# vim: set filetype=zsh :

integer jour_mois jour_semaine

jour_mois=`date +%d`
jour_semaine=`date +%u`

# Numéro de la semaine {{{1

semaine=0

(( jour_semaine == 1 )) && (( jour_mois <= 3 )) && semaine=1
(( jour_semaine == 2 )) && (( jour_mois <= 4 )) && semaine=1
(( jour_semaine == 3 )) && (( jour_mois <= 5 )) && semaine=1
(( jour_semaine == 4 )) && (( jour_mois <= 6 )) && semaine=1
(( jour_semaine == 5 )) && (( jour_mois <= 7 )) && semaine=1

(( jour_semaine == 1 )) && (( jour_mois >= 4 )) && (( jour_mois <= 10 )) && semaine=2
(( jour_semaine == 2 )) && (( jour_mois >= 5 )) && (( jour_mois <= 11 )) && semaine=2
(( jour_semaine == 3 )) && (( jour_mois >= 6 )) && (( jour_mois <= 12 )) && semaine=2
(( jour_semaine == 4 )) && (( jour_mois >= 7 )) && (( jour_mois <= 13 )) && semaine=2
(( jour_semaine == 5 )) && (( jour_mois >= 8 )) && (( jour_mois <= 14 )) && semaine=2

(( jour_semaine == 1 )) && (( jour_mois >= 11 )) && (( jour_mois <= 17 )) && semaine=3
(( jour_semaine == 2 )) && (( jour_mois >= 12 )) && (( jour_mois <= 18 )) && semaine=3
(( jour_semaine == 3 )) && (( jour_mois >= 13 )) && (( jour_mois <= 19 )) && semaine=3
(( jour_semaine == 4 )) && (( jour_mois >= 14 )) && (( jour_mois <= 20 )) && semaine=3
(( jour_semaine == 5 )) && (( jour_mois >= 15 )) && (( jour_mois <= 21 )) && semaine=3

(( jour_semaine == 1 )) && (( jour_mois >= 18 )) && (( jour_mois <= 24 )) && semaine=4
(( jour_semaine == 2 )) && (( jour_mois >= 19 )) && (( jour_mois <= 25 )) && semaine=4
(( jour_semaine == 3 )) && (( jour_mois >= 20 )) && (( jour_mois <= 26 )) && semaine=4
(( jour_semaine == 4 )) && (( jour_mois >= 21 )) && (( jour_mois <= 27 )) && semaine=4
(( jour_semaine == 5 )) && (( jour_mois >= 22 )) && (( jour_mois <= 28 )) && semaine=4

(( jour_semaine == 1 )) && (( jour_mois >= 25 )) && semaine=5
(( jour_semaine == 2 )) && (( jour_mois >= 26 )) && semaine=5
(( jour_semaine == 3 )) && (( jour_mois >= 27 )) && semaine=5
(( jour_semaine == 4 )) && (( jour_mois >= 28 )) && semaine=5
(( jour_semaine == 5 )) && (( jour_mois >= 29 )) && semaine=5

# }}}1

# @ Roulement ? {{{1

roulement=0

(( jour_semaine == 5 )) && (( jour_mois >= 15 )) && (( jour_mois <= 21 )) && roulement=1

demain_roulement=0

(( jour_semaine == 4 )) && (( jour_mois >= 14 )) && (( jour_mois <= 20 )) && demain_roulement=1

semaine_roulement=0

(( jour_semaine == 3 )) && (( jour_mois >= 13 )) && (( jour_mois <= 19 )) && semaine_roulement=1
(( jour_semaine == 2 )) && (( jour_mois >= 12 )) && (( jour_mois <= 18 )) && semaine_roulement=1
(( jour_semaine == 1 )) && (( jour_mois >= 11 )) && (( jour_mois <= 17 )) && semaine_roulement=1

# }}}1

# Affichage {{{1

affiche=0

(( $# > 0 )) && [[ $1 = -d ]] && affiche=1

(( demain_roulement == 1 )) && affiche=1

(( roulement == 1 )) && affiche=1

(( affiche == 1 )) && {

	echo " ------------------------------------"
	echo "  Roulement échéance @ future"
	echo " ------------------------------------"
	echo
	echo "  Jour du mois : $jour_mois"
	echo
	echo "  Jour de la semaine : $jour_semaine"
	echo
	echo "  Semaine : $semaine"
	echo
	echo "  Roulement : $roulement"
	echo
	echo "  Demain roulement : $demain_roulement"
	echo
	echo "  Semaine roulement : $semaine_roulement"
	echo
}

# }}}1

# bell {{{1

(( semaine > 0 )) && bell.zsh ~/audio/bell/finance/semaine-$semaine.ogg
(( roulement == 1 )) && bell.zsh ~/audio/bell/finance/roulement-ajd.ogg
(( demain_roulement == 1 )) && bell.zsh ~/audio/bell/finance/roulement-demain.ogg
(( semaine_roulement == 1 )) && bell.zsh ~/audio/bell/finance/roulement-semaine.ogg

# }}}1

# Fini

exit 0
