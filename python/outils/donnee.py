#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim: set filetype=python :

# {{{ Importations

import re

import types

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ arrondi

def arrondi(nombre, precision = 0) :

	if precision == 0 : return int(nombre)

	dixprec = 10 ** precision

	n = round(nombre * dixprec) / dixprec

	return n

# }}}

# ========================================================================

# {{{ chiffresSignificatifs

def chiffresSignificatifs(nombre, Nchiffres = 4) :

	if Nchiffres == 0 : return int(nombre)

	absNombre = abs(nombre)

	N = 0
	dixN = 1

	while absNombre > dixN :

		N += 1

		dixN *= 10

	precision = max(Nchiffres - N, 0)

	return arrondi(nombre, precision)

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ estEntier

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estEntier(n):

	"""estentier(n): dit si une variable est un nombre entier ou un entier long (renvoie True ou False)"""

	return isinstance(n,(types.IntType,types.LongType))

# }}}

# ========================================================================

# {{{ estNombre

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estNombre(x):

	"""estnombre(x): dit si une variable est un nombre entier, long ou flottant (renvoie True ou False)"""

	return isinstance(x,(types.IntType,types.LongType,types.FloatType))

# }}}

# ========================================================================

# {{{ estChaine

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estChaine(t):

	"""estchaine(t): dit si une variable est une chaîne (unicode ou non) (renvoie True ou False)"""

	return isinstance(t,(types.StringTypes))

# }}}

# ========================================================================

# {{{ estListe

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estListe(L):

	"""estliste(L): dit si une variable est une liste (renvoie True ou False)"""

	return isinstance(L,(types.ListType))

# }}}

# ========================================================================

# {{{ estTuple

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estTuple(T):

	"""esttuple(T): dit si une variable est un tuple (renvoie True ou False)"""

	return isinstance(T,(types.TupleType))

# }}}

# ========================================================================

# {{{ estDict

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estDict(D):

	"""estdict(D): dit si une variable est un dictionnaire (renvoie True ou False)"""

	return isinstance(D,(types.DictType))

# }}}

# ========================================================================

# {{{ estFonction

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estFonction(fn):

	"""estfonction(fn): dit si f est un nom de fonction intégrée, utilisateur ou lambda (renvoie True ou False)"""

	return isinstance(fn,(types.BuiltinFunctionType,types.FunctionType))

# }}}

# ========================================================================

# {{{ estAppelable

# Adaptation d'une fonction trouvée sur la page :
#
# http://python.jpvweb.com/mesrecettespython/tri_rapide
#
# Merci à l'auteur :)

def estAppelable(fonction):

	return callable(fonction)

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ nombre2chaine

def nombre2chaine(nombre, N) :

	#return str(arrondi(nombre, N))
	return str(chiffresSignificatifs(nombre, N))

# }}}

# ========================================================================

# {{{ virgule2point

def virgule2point(chaine, precision = 0) :

	return float(re.sub(r',', r'.', chaine))

# }}}

# ========================================================================

# {{{ point2virgule

def point2virgule(nombre, precision = 0) :

	#return re.sub(r'\.', r',', str(arrondi(nombre, precision)))
	return re.sub(r'\.', r',', nombre2chaine(nombre, precision))

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ representeUnEntier

def representeUnEntier(chaine) :

	try : int(chaine)

	except ValueError : return False

	else : return True

# }}}

# ========================================================================

# {{{ representeUnReel

def representeUnReel(chaine) :

	try : virgule2point(chaine)

	except ValueError : return False

	else : return True

# }}}

# ========================================================================

# {{{ representeUnNombre

def representeUnNombre(chaine) :

	return representeUnEntier(chaine) or representeUnReel(chaine)

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ lignesFichier

def lignesFichier(entree, separateur = ' ') :

	if isinstance(entree, file) : fichier = entree
	else : fichier = open(entree, 'r')

	return fichier.readlines()

# }}}

# ========================================================================

# {{{ fichier2liste

def fichier2liste(entree, separateur = ' ') :

	if isinstance(entree, file) : fichier = entree
	else : fichier = open(entree, 'r')

	liste = fichier.read().replace('\n', separateur).split(separateur)

	return [elt for elt in liste if elt != '']

# }}}

# ========================================================================

# {{{ justifie

def justifie(liste, sortie, tranche) :

	"""
	Ecris une liste dans un fichier en comptant 'tranche' elements par ligne
	"""

	if isinstance(sortie, file) : fichier = sortie
	else : fichier = open(sortie, 'w')

	j = 0
	k = 0
	N = len(liste)

	while j < N :

		i = 0 + k * tranche
		j = tranche + k * tranche

		k = k + 1

		tableau = [str(elt) for elt in liste[i:j]]

		chaine = ' '.join(tableau)

		fichier.write(chaine + '\n')

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ main

if __name__ == '__main__' :

	pass

# }}}
