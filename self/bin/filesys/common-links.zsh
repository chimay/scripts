#! /usr/bin/env zsh

# {{{ Dossiers

dossiers=()

dossiers+=(~/racine)

dossiers+=(~/racine/artisan)
dossiers+=(~/racine/automat)
dossiers+=(~/racine/bin)
dossiers+=(~/racine/common)
dossiers+=(~/racine/config/*(/))
dossiers+=(~/racine/dotdir)
dossiers+=(~/racine/feder)
dossiers+=(~/racine/fun)
dossiers+=(~/racine/hist)
dossiers+=(~/racine/hub)
dossiers+=(~/racine/humour)
dossiers+=(~/racine/index)
dossiers+=(~/racine/infoman)
dossiers+=(~/racine/install)
dossiers+=(~/racine/liber)
dossiers+=(~/racine/litera)
dossiers+=(~/racine/log)
dossiers+=(~/racine/mail)
dossiers+=(~/racine/matemat)
dossiers+=(~/racine/meta)
dossiers+=(~/racine/multics)
dossiers+=(~/racine/musica)
dossiers+=(~/racine/news)
dossiers+=(~/racine/omni)
dossiers+=(~/racine/pack)
dossiers+=(~/racine/papier)
dossiers+=(~/racine/physic)
dossiers+=(~/racine/pictura)
dossiers+=(~/racine/plain)
dossiers+=(~/racine/plugin/data)
dossiers+=(~/racine/public)
dossiers+=(~/racine/refer)
dossiers+=(~/racine/repo)
dossiers+=(~/racine/scien)
dossiers+=(~/racine/self)
dossiers+=(~/racine/shell)
dossiers+=(~/racine/site)
dossiers+=(~/racine/snippet)
dossiers+=(~/racine/syncron)
dossiers+=(~/racine/system)
dossiers+=(~/racine/template)
dossiers+=(~/racine/void)
dossiers+=(~/racine/wiki)

# Via hub

dossiers+=(~/racine/hub/home/graphix)
dossiers+=(~/racine/hub/home/photo)

dossiers+=(~/racine/hub/home/log)

# }}}

# {{{ Racine-projet

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .racine-projet ]] && {

		echo "Le fichier racine-projet dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .racine-projet ]] || {

		echo "Le fichier racine-projet dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/racine-projet .racine-projet"
		echo

		ln -s ~/racine/common/target/racine-projet .racine-projet
		echo

		ls -l $reper/.racine-projet

		continue
	}

	[[ -f .racine-projet ]] || {

		echo "Le fichier racine-projet  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .racine-projet ~/racine/common/target/racine-projet >& /dev/null && {

		echo "Le fichier racine-projet  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .racine-projet"
		echo

		rm -f .racine-projet

		echo "ln -s ~/racine/common/target/racine-projet .racine-projet"
		echo

		ln -s ~/racine/common/target/racine-projet .racine-projet
		echo

		ls -l $reper/.racine-projet

		continue
	}

	diff .racine-projet ~/racine/common/target/racine-projet >& /dev/null || {

		echo "Le fichier racine-projet  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}

# {{{ Projectile

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .projectile ]] && {

		echo "Le fichier projectile dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .projectile ]] || {

		echo "Le fichier projectile dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/projectile .projectile"
		echo

		ln -s ~/racine/common/target/projectile .projectile
		echo

		ls -l $reper/.projectile

		continue
	}

	[[ -f .projectile ]] || {

		echo "Le fichier projectile  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .projectile ~/racine/common/target/projectile >& /dev/null && {

		echo "Le fichier projectile  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .projectile"
		echo

		rm -f .projectile

		echo "ln -s ~/racine/common/target/projectile .projectile"
		echo

		ln -s ~/racine/common/target/projectile .projectile
		echo

		ls -l $reper/.projectile

		continue
	}

	diff .projectile ~/racine/common/target/projectile >& /dev/null || {

		echo "Le fichier projectile  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}

# {{{ Gitignore

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .gitignore ]] && {

		echo "Le fichier gitignore dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .gitignore ]] || {

		echo "Le fichier gitignore dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/gitignore .gitignore"
		echo

		ln -s ~/racine/common/target/gitignore .gitignore
		echo

		ls -l $reper/.gitignore

		continue
	}

	[[ -f .gitignore ]] || {

		echo "Le fichier gitignore  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .gitignore ~/racine/common/target/gitignore >& /dev/null && {

		echo "Le fichier gitignore  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .gitignore"
		echo

		rm -f .gitignore

		echo "ln -s ~/racine/common/target/gitignore .gitignore"
		echo

		ln -s ~/racine/common/target/gitignore .gitignore
		echo

		ls -l $reper/.gitignore

		continue
	}

	diff .gitignore ~/racine/common/target/gitignore >& /dev/null || {

		echo "Le fichier gitignore  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}

# {{{ Hgignore

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .hgignore ]] && {

		echo "Le fichier hgignore dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .hgignore ]] || {

		echo "Le fichier hgignore dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/hgignore .hgignore"
		echo

		ln -s ~/racine/common/target/hgignore .hgignore
		echo

		ls -l $reper/.hgignore

		continue
	}

	[[ -f .hgignore ]] || {

		echo "Le fichier hgignore  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .hgignore ~/racine/common/target/hgignore >& /dev/null && {

		echo "Le fichier hgignore  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .hgignore"
		echo

		rm -f .hgignore

		echo "ln -s ~/racine/common/target/hgignore .hgignore"
		echo

		ln -s ~/racine/common/target/hgignore .hgignore
		echo

		ls -l $reper/.hgignore

		continue
	}

	diff .hgignore ~/racine/common/target/hgignore >& /dev/null || {

		echo "Le fichier hgignore  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}

# {{{ Bzrignore

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .bzrignore ]] && {

		echo "Le fichier bzrignore dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .bzrignore ]] || {

		echo "Le fichier bzrignore dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/bzrignore .bzrignore"
		echo

		ln -s ~/racine/common/target/bzrignore .bzrignore
		echo

		ls -l $reper/.bzrignore
		echo

		pwd
		echo

		continue
	}

	[[ -f .bzrignore ]] || {

		echo "Le fichier bzrignore  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .bzrignore ~/racine/common/target/bzrignore >& /dev/null && {

		echo "Le fichier bzrignore  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .bzrignore"
		echo

		rm -f .bzrignore

		echo "ln -s ~/racine/common/target/bzrignore .bzrignore"
		echo

		ln -s ~/racine/common/target/bzrignore .bzrignore
		echo

		ls -l $reper/.bzrignore

		continue
	}

	diff .bzrignore ~/racine/common/target/bzrignore >& /dev/null || {

		echo "Le fichier bzrignore  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}

# {{{ Archive-exclude

for reper in $dossiers
do
	echo "------------------------------"
	echo

	cd $reper

	[[ -L .archive-exclude ]] && {

		echo "Le fichier archive-exclude dans < $reper > est déjà un lien"
		echo

		continue
	}

	[[ -e .archive-exclude ]] || {

		echo "Le fichier archive-exclude dans < $reper > n’existe pas :"
		echo "    on le crée"
		echo

		echo "ln -s ~/racine/common/target/archive-exclude .archive-exclude"
		echo

		ln -s ~/racine/common/target/archive-exclude .archive-exclude
		echo

		ls -l $reper/.archive-exclude

		continue
	}

	[[ -f .archive-exclude ]] || {

		echo "Le fichier archive-exclude  dans < $reper > n’est pas un fichier régulier !"
		echo

		continue
	}

	diff .archive-exclude ~/racine/common/target/archive-exclude >& /dev/null && {

		echo "Le fichier archive-exclude  dans < $reper > est identique au fichier commun :"
		echo "    on le remplace par un lien vers le fichier commun"
		echo

		echo "rm -f .archive-exclude"
		echo

		rm -f .archive-exclude

		echo "ln -s ~/racine/common/target/archive-exclude .archive-exclude"
		echo

		ln -s ~/racine/common/target/archive-exclude .archive-exclude
		echo

		ls -l $reper/.archive-exclude

		continue
	}

	diff .archive-exclude ~/racine/common/target/archive-exclude >& /dev/null || {

		echo "Le fichier archive-exclude  dans < $reper > diffère du fichier commun :"
		echo "    on ne le remplace pas"
		echo
	}

done

# }}}
