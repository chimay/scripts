#! /usr/bin/env python
# -*- coding: utf-8 -*-

# {{{ Importations

import os, sys, glob, re, subprocess, random

import outils.donnee as outidonnee

# }}}

# {{{ Variables

maison = os.environ['HOME']

racineParDefaut = maison + '/audio'

ChiffresLettres = [
	'0', '1', '2', '3', '4',
	'5', '6', '7', '8', '9',
	'A', 'B', 'C', 'D', 'E',
	'F', 'G', 'H', 'I', 'J',
	'K', 'L', 'M', 'N', 'O',
	'P', 'Q', 'R', 'S', 'T',
	'U', 'V', 'W', 'X', 'Y',
	'Z'
]

#ScoresChiffresLettres = range(36, 0, -1)

ScoresChiffresLettres = [
	30, 29, 28, 27, 26,		# 0
	25, 24, 23, 22, 21,		# 5
	20, 19, 18, 17, 16,		# A
	15, 14, 13, 12, 11,		# F
	10, 9, 8, 7, 6,			# K
	5, 4, 3, 2, 1,			# P
	0, -100, -200, -300, -400,	# U
	-1000				# Z
]

noteParDefaut = ScoresChiffresLettres[ChiffresLettres.index('U')]

dispersionParDefaut = 12
ponderationParDefaut = [1, 1]

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ directives

def directives(fichier_gen, dejaInclus = '') :

	racine = racineParDefaut

	repertoires = open(fichier_gen, 'r').readlines()

	if dejaInclus == '' or dejaInclus == None : dejaInclus = fichier_gen
	else : dejaInclus += '|' + fichier_gen

	antiboucle = re.compile(dejaInclus)

	raci = re.compile('^%root ')
	tilde = re.compile('~')

	inclu = re.compile('^%include ')
	exclu = re.compile('^%exclude ')

	commentaires = re.compile('^#')

	exclusions = []

	# On enlève les fins de repertoires
	# ------------------------------------------------------------

	for i in range(len(repertoires)) : repertoires[i] = repertoires[i][:-1]

	# Boucle
	# ------------------------------------------------------------

	encore = True

	while encore :

		encore = False

		for i in range(len(repertoires)) :

			elt = repertoires[i]

			if raci.search(elt) :

				encore = True

				del repertoires[i]

				racine = raci.sub('', elt)
				racine = tilde.sub(maison, racine)

				break

			if inclu.search(elt) != None :

				encore = True

				del repertoires[i]

				if antiboucle.search(elt) == None :

					F = inclu.sub('', elt)

					racine, L, E = directives(F, dejaInclus)

					dejaInclus += '|' + F
					antiboucle = re.compile(dejaInclus)

					repertoires.extend(L)
					exclusions.extend(E)

				break

			elif exclu.search(elt) != None :

				encore = True

				del repertoires[i]

				E = exclu.sub('', elt)

				exclusions.append(E)

				break

			elif commentaires.search(elt) != None :

				encore = True

				del repertoires[i]

				break

	# Retour
	# ------------------------------------------------------------

	return racine, repertoires, exclusions

# }}}

# {{{ englobe

def englobe(repertoires, exclusions) :

	# *.(ogg|mp3|flac)
	#motifFichiers = re.compile('.+\.(ogg|mp3|flac)$')

	# *.*
	motifFichiers = re.compile('^.+\..+$')

	fichiers = []

	for rep in repertoires :
		for chemin, sousrep, fich in os.walk(rep, followlinks = True) :
			for elt in fich :
				if motifFichiers.search(elt) != None :
					fichiers.append(chemin + '/' + elt)

	fichiersExclus = []

	for rep in exclusions :
		for chemin, sousrep, fich in os.walk(rep) :
			for elt in fich :
				if motifFichiers.search(elt) != None :
					fichiersExclus.append(chemin + '/' + elt)

	sans = set(fichiers) - set(fichiersExclus)

	fichiers = list(sans)

	return fichiers

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ notesFichiersDapresNoms

def notesFichiersDapresNoms(fichiers) :

	notes = []

	repertoires = re.compile('^.*/')

	for fich in fichiers :

		nomDeFichier = repertoires.sub('', fich)
		chaine = nomDeFichier[0]

		if str.islower(chaine) : chaine = str.upper(chaine)

		if chaine[0] in ChiffresLettres :
			notes.append(ScoresChiffresLettres[ChiffresLettres.index(chaine[0])])
		else : notes.append(noteParDefaut)

		#print(fich, chaine)

	return notes

# }}}

# {{{ notesFichiersDapresEtiquettes

def notesFichiersDapresEtiquettes(entree, fichiers) :

	notes = []

	subst = re.compile('^.* : ')

	for fich in fichiers :

		processus = subprocess.Popen(
			['noteMorceau.sh', 'ls', fich],
			stdout=subprocess.PIPE
		)

		chaine = processus.communicate()[0]

		#if processus.returncode != 0 : print(fich)

		chaine = subst.sub('', chaine)[:-1]

		if chaine == '' : notes.append(noteParDefaut)
		elif chaine[0] in ChiffresLettres :
			notes.append(ScoresChiffresLettres[ChiffresLettres.index(chaine[0])])
		else :
			try : notes.append(int(chaine))
			except ValueError : notes.append(noteParDefaut)
			else : print(fich)

		#print(fich, notes[-1])

	return notes

# }}}

# {{{ notesFichiersDapresCache

def notesFichiersDapresCache(entree, fichiers) :

	"""
	Utilise le cache généré par :

	~/bin/zsh/audio/m3uCacheNotes.zsh
	"""

	notes = []

	cache = open('cache', 'r').readlines()

	cache.sort()

	subst = re.compile('^.* : ')

	repertoires = re.compile('^.*/')

	Ncache = len(cache)

	NcacheMoinsUn = Ncache - 1

	if Ncache == 0 :
		print("Fichier de cache vide !")
		exit(0)

	debut = 0

	for fich in fichiers :

		motif = re.compile('^' + fich + ' : ')

		for i in range(debut, Ncache) :
			if motif.search(cache[i]) != None : break

		#print(i, fich, cache[i])

		debut = i

		if debut < NcacheMoinsUn : chaine = subst.sub('', cache[i])[:-1]
		else :
			nomDeFichier = repertoires.sub('', fich)
			chaine = nomDeFichier[0]
			debut = 0
			print("Utilisation de la première lettre : ", chaine, fich)

		if str.islower(chaine) : chaine = str.upper(chaine)

		if chaine[0] in ChiffresLettres :
			notes.append(ScoresChiffresLettres[ChiffresLettres.index(chaine[0])])
		else :
			try : notes.append(int(chaine))
			except ValueError : notes.append(noteParDefaut)
			else : print(fich)

		#print(fich, chaine)

	return notes

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ notesRepertoiresDapresNoms

def notesRepertoiresDapresNoms(fichiers) :

	notes = []

	fin = re.compile('/[^/]*$')
	debut = re.compile('^.*/')

	for fich in fichiers :

		inter = fin.sub('', fich)
		nomDeRepertoire = debut.sub('', inter)
		chaine = nomDeRepertoire[0]

		if str.islower(chaine) : chaine = str.upper(chaine)

		if chaine[0] in ChiffresLettres :
			notes.append(ScoresChiffresLettres[ChiffresLettres.index(chaine[0])])
		else : notes.append(noteParDefaut)

		#print(fich, nomDeRepertoire, chaine)

	return notes

# }}}

# {{{ notesRepertoiresDapresFichierEval

def notesRepertoiresDapresFichierEval(fichiers, racine = racineParDefaut) :

	repercour = os.getcwd()

	#print('repercour : ', repercour)

	notes = []

	fin = re.compile('/[^/]*$')

	joker = "?-evaluation"

	for fich in fichiers :

		repertoire = fin.sub('', fich)

		os.chdir(repercour + '/' + repertoire)

		while True :

			englobage = glob.glob(joker)

			#print(os.getcwd(), englobage)

			if len(englobage) != 0 or os.getcwd() == racine or os.getcwd() == '/' :
				break

			os.chdir('..')

		if len(englobage) == 0 :
			notes.append(noteParDefaut)
			continue

		fichierEval = englobage[0]

		chaine = fichierEval[0]

		if str.islower(chaine) : chaine = str.upper(chaine)

		if chaine[0] in ChiffresLettres :
			notes.append(ScoresChiffresLettres[ChiffresLettres.index(chaine[0])])
		else : notes.append(noteParDefaut)

		#print(fich, nomDeRepertoire, chaine)

	os.chdir(repercour)

	return notes

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ triAleatoire

def triAleatoire(fichiers, notes, dispersion) :

	positions = []

	for elt in notes : positions.append(random.gauss(elt, dispersion))

	coupoles = []

	for i in range(len(fichiers)) : coupoles.append( (positions[i], fichiers[i]) )

	coupoles.sort()
	coupoles.reverse()

	fichiersTries = [ elt[1] for elt in coupoles ]

	#print([ elt[0] for elt in coupoles ])

	return fichiersTries

# }}}

# {{{ impression

def impression(fichiers, sortie) :

	fichierSortie = open(sortie, 'w')

	for f in fichiers :

		fichierSortie.write(f + '\n')

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ principal

def principal(arguments) :

	# {{{ Initialisation

	dispersion = dispersionParDefaut
	ponderation = ponderationParDefaut

	nombres = []
	chaines = []

	# }}}

	# {{{ Nombre d’arguments minimal

	if len(arguments) < 2 :

		repertoires = re.compile('^.*/')

		fichier = repertoires.sub('', __file__)

		print("Usage : ", fichier, " [dispersion] fichier-gen")

		exit(1)

	# }}}

	# {{{ Tri des arguments

	while len(arguments) > 1 :

		der = arguments.pop()

		if outidonnee.representeUnNombre(der) : nombres.append(float(der))
		else : chaines.append(der)

	# }}}

	# {{{ Nombres

	nombres.reverse()

	if len(nombres) > 0 : dispersion = nombres[0]
	if len(nombres) > 1 : ponderation[0] = nombres[1]
	if len(nombres) > 2 : ponderation[1] = nombres[2]

	# }}}

	# {{{ Dossier des fichiers.gen

	chaines.reverse()

	entree = chaines[0]

	substBase = re.compile('/[^/]*$')
	substDir = re.compile('^([^/]*/)*')

	dossier_gen = substBase.sub('', entree)
	fichier_gen = substDir.sub('', entree)

	if dossier_gen == entree : dossier_gen = os.getcwd()

	# }}}

	# {{{ Directives : %include, %exclude, ...

	os.chdir(dossier_gen)

	racine, repertoires, exclusions = directives(fichier_gen)

	repertoires = list(set(repertoires))
	exclusions = list(set(exclusions))

	#print(repertoires, exclusions)

	# }}}

	# {{{ Affichage

	print("Dispersion : ", dispersion)
	print("")
	print("Ponderation : ", ponderation[0], ponderation[1])
	print("")
	print("Entree : ", entree)
	print("")
	print("Repertoire racine : ", racine)
	print("")
	print("Dossier gen : ", dossier_gen)
	print("")
	print("Fichier gen : ", fichier_gen)
	print("")
	print("------------------------------------")
	print("")

        # print("Dispersion : ", dispersion, file=sys.stderr)
        # print("", file=sys.stderr)

	# }}}

	# {{{ Fichiers contenus dans les répertoires

	os.chdir(racine)

	fichiers = englobe(repertoires, exclusions)

	fichiers.sort()

	# }}}

	# {{{ Obtention des notes

	#notes = notesFichiersDapresEtiquettes(fichiers)

	#os.chdir(dossier_gen)
	#notes = notesFichiersDapresCache(fichiers)

	notesFichiers = notesFichiersDapresNoms(fichiers)

	#notesRepertoires = notesRepertoiresDapresNoms(fichiers)
	notesRepertoires = notesRepertoiresDapresFichierEval(fichiers, racine)

	notes = [ponderation[0] * notesFichiers[i] + ponderation[1] * notesRepertoires[i] \
		for i in range(len(fichiers))]

	for i in range(len(fichiers)) :
		print('\t\t', notesFichiers[i], '\t\t', notesRepertoires[i], '\t\t', notes[i], '\t\t', fichiers[i])

	# }}}

	# {{{ Tri aléatoire

	fichiersTries = triAleatoire(fichiers, notes, dispersion)

	#print(fichiers)

	# }}}

	# {{{ Ecriture

	os.chdir(dossier_gen)

	sortie = re.sub('\..*', '.m3u', entree)

	impression(fichiersTries, sortie)

	# }}}

# }}}

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# {{{ main

if __name__ == '__main__' :

	principal(sys.argv)

# }}}
