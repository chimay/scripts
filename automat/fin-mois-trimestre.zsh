#! /usr/bin/env zsh

# vim: set filetype=zsh :

# Derniers jours ouvrables du mois ou du trimestre
#
# Version améliorée du crontab :
#
# 2	10	30	1,3,5,7,8,10,12	*	bell.zsh ~/audio/bell/finance/fin-mois-demain.ogg &>>! ~/log/cron.log
# 2	10	31	1,3,5,7,8,10,12	*	bell.zsh ~/audio/bell/finance/fin-mois-ajd.ogg &>>! ~/log/cron.log
#
# 2	10	29	4,6,9,11	*	bell.zsh ~/audio/bell/finance/fin-mois-demain.ogg &>>! ~/log/cron.log
# 2	10	30	4,6,9,11	*	bell.zsh ~/audio/bell/finance/fin-mois-ajd.ogg &>>! ~/log/cron.log
#
# 2	10	27	2	*	bell.zsh ~/audio/bell/finance/fin-mois-demain.ogg &>>! ~/log/cron.log
# 2	10	28	2	*	bell.zsh ~/audio/bell/finance/fin-mois-ajd.ogg &>>! ~/log/cron.log
#
# 3	10	30	3,12	bell.zsh ~/audio/bell/finance

integer jour_mois jour_semaine
integer mois

jour_mois=`date +%d`
jour_semaine=`date +%w`

mois=`date +%m`

# Affichage {{{1

echo "  Jour du mois : $jour_mois"
echo
echo "  Jour de la semaine : $jour_semaine"
echo
echo "  Mois : $mois"
echo

# }}}1

# Inutile le week-end {{{1

(( jour_semaine == 6 )) &&  exit 0
(( jour_semaine == 0 )) &&  exit 0

# }}}1

# Classement des mois {{{1

trente_et_un=(1 3 5 7 8 10 12)
trente=(4 6 9 11)
vingt_huit=(2)

if [[ ${trente_et_un[(i)$mois]} -le $#trente_et_un ]]
then
	echo "  Mois de trente-et-un jours"
	echo

	borne=31

elif [[ ${trente[(i)$mois]} -le $#trente ]]
then
	echo "  Mois de trente jours"
	echo

	borne=30

elif [[ ${vingt_huit[(i)$mois]} -le $#vingt_huit ]]
then
	echo "  Mois de février ~ vingt-huit jours"
	echo

	borne=28
fi

# }}}1

# Mois en fin de trimestres {{{1

mois_trimestres=(3 6 9 12)

mois_et_trimestre=0

if [[ ${mois_trimestres[(i)$mois]} -le $#mois_trimestres ]]
then
	echo "  Ce mois correspond à la fin d’un trimestre"
	echo

	mois_et_trimestre=1
fi

# }}}1

# Boucle -> fin du mois {{{1

echo "  Boucle -> fin du mois"
echo "  ------------------------------"
echo

calendrier=$jour_mois
rotation=$jour_semaine

dernier_jour_mois=$jour_mois
dernier_jour_semaine=$jour_semaine

while (( calendrier <= borne ))
do
	echo "  Jour du mois : $calendrier"
	echo "  Jour de la semaine : $rotation"
	echo

	(( rotation >= 1 )) && (( rotation <= 5 )) && {

		dernier_jour_mois=$calendrier
		dernier_jour_semaine=$rotation
	}

	echo "  Dernier jour du mois jusqu’ici : $dernier_jour_mois"
	echo "  Dernier jour de la semaine jusqu’ici : $dernier_jour_semaine"
	echo

	(( calendrier = calendrier + 1 ))
	(( rotation = (rotation + 1) % 7 ))
done

# }}}1

# Jour ouvrable précédent {{{1

if (( dernier_jour_semaine == 1 ))
then
	(( avant_dernier_jour_mois = dernier_jour_mois - 3 ))

elif (( dernier_jour_semaine >= 2 )) && (( dernier_jour_semaine <= 5 ))
then
	(( avant_dernier_jour_mois = dernier_jour_mois - 1 ))
fi

echo "  Avant-dernier jour du mois : $avant_dernier_jour_mois"
echo

# }}}1

# Sonnerie {{{1

(( jour_mois == dernier_jour_mois )) && {

	bell.zsh ~/audio/bell/finance/fin-mois-ajd.ogg &>>! ~/log/cron.log

	(( mois_et_trimestre == 1 )) && \
		bell.zsh ~/audio/bell/finance/fin-trimestre-ajd.ogg &>>! ~/log/cron.log
}

(( jour_mois == avant_dernier_jour_mois )) && {

	bell.zsh ~/audio/bell/finance/fin-mois-demain.ogg &>>! ~/log/cron.log

	(( mois_et_trimestre == 1 )) && \
		bell.zsh ~/audio/bell/finance/fin-trimestre-demain.ogg &>>! ~/log/cron.log
}

# }}}1
