#! /usr/bin/env zsh

# vim: set filetype=zsh :

integer jour_mois jour_semaine

jour_mois=`date +%d`
jour_semaine=`date +%u`

#  {{{ BCE

bce=0

(( jour_semaine == 4 )) && (( jour_mois >= 1 )) && (( jour_mois <= 7 )) && bce=1

# Sonnerie

(( bce == 1 )) && bell.zsh ~/audio/sonnerie/finance/bce.ogg

# Affichage

echo " ------------------------------------"
echo "  BCE"
echo " ------------------------------------"
echo
echo "  Jour du mois : $jour_mois"
echo
echo "  Jour de la semaine : $jour_semaine"
echo
echo "  BCE : $bce"
echo

#  }}}

# Fini

exit 0
