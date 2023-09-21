#!/usr/bin/env zsh

# TODO

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
	dossiers+=(infoman)
	dossiers+=(install)
	dossiers+=(litera)
	dossiers+=(log)
	dossiers+=(mail)
	dossiers+=(multics)
	dossiers+=(musica)
	dossiers+=(news)
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

	dossiers+=(self/hub/log)
fi

if (( $# > 0 ))
then
	dossiers=($*)
else
	cd ~/racine

	dossiers=()

	dossiers+=(artisan)
	dossiers+=(automat)
	dossiers+=(bin)
	dossiers+=(common)
	dossiers+=(config/*(/))
	dossiers+=(dotdir)
	dossiers+=(feder)
	dossiers+=(fun)
	dossiers+=(hist)
	dossiers+=(hub)
	dossiers+=(humour)
	dossiers+=(index)
	dossiers+=(infoman)
	dossiers+=(install)
	dossiers+=(liber)
	dossiers+=(litera)
	dossiers+=(log)
	dossiers+=(mail)
	dossiers+=(meta)
	dossiers+=(multics)
	dossiers+=(musica)
	dossiers+=(news)
	dossiers+=(omni)
	dossiers+=(pack)
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

# Boucle {{{1

for reper in $dossiers
do
	echo
	echo "------------------------------------"
	echo

	echo "cd $reper"
	echo

	cd $reper

	[[ -d .brz ]] || {

		echo "brz init ."
		echo

		brz init .

		echo "brz add"
		echo

		brz add

		echo "brz commit -m \"Importation initiale\""
		echo

		brz commit -m "Importation initiale"
	}

	cd -
done
