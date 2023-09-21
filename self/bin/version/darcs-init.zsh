#!/usr/bin/env zsh

setopt null_glob

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

# {{{ Dossiers à archiver

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
	dossiers+=(site)
	dossiers+=(snippet)
	dossiers+=(system)
	dossiers+=(template)
	dossiers+=(void)

	# Via hub

	dossiers+=(hub/log)
fi

# }}}

#  {{{ Boucle

for reper in $dossiers
do
	echo
	echo "------------------------------------"
	echo

	echo "cd $reper"
	echo

	cd $reper

	[[ -d .darcs ]] || {

		echo "darcs init"
		echo

		darcs init

		echo "cp -f ~/racine/common/target/darcsignore _darcs/prefs/boring"
		echo

		cp -f ~/racine/common/target/darcsignore _darcs/prefs/boring

		echo "darcs add -r *"
		echo

		darcs add -r *

		echo "darcs record -a -m \"Importation initiale\""
		echo

		darcs record -a -m "Importation initiale"
	}

	cd -
done

#  }}}
