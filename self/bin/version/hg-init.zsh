#!/usr/bin/env zsh

setopt null_glob

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

# Dossiers à archiver {{{1

if (( $# > 0 ))
then
	dossiers=($*)
else
	cd ~/racine

	dossiers=()

	dossiers+=(artisan)
	dossiers+=(automat)
	dossiers+=(common)
	dossiers+=(config/*(/))
	dossiers+=(dotdir)
	dossiers+=(feder)
	dossiers+=(fun)
	dossiers+=(hist)
	dossiers+=(hub)
	dossiers+=(humour)
	dossiers+=(index)
	dossiers+=(install)
	dossiers+=(litera)
	dossiers+=(log)
	dossiers+=(multics)
	dossiers+=(musica)
	dossiers+=(news)
	dossiers+=(omni)
	dossiers+=(pack/bin)
	dossiers+=(papier)
	dossiers+=(pictura)
	dossiers+=(plain)
	dossiers+=(plugin/data)
	dossiers+=(refer)
	dossiers+=(repo)
	dossiers+=(scien)
	dossiers+=(self)
	dossiers+=(shell)
	dossiers+=(snippet)
	dossiers+=(system)
	dossiers+=(template)
	dossiers+=(void)

	# Via hub

	dossiers+=(hub/log)
fi

#  Boucle {{{1

for reper in $dossiers
do
	echo
	echo "------------------------------------"
	echo

	echo "cd $reper"
	echo

	cd $reper

	[[ -d .hg ]] || {

		echo "hg init"
		echo

		hg init

		echo "hg add ."
		echo

		hg add .

		echo "hg commit -m \"Importation initiale\""
		echo

		hg commit -m "Importation initiale"
	}

	cd -
done
