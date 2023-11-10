#! /usr/bin/env zsh

setopt nullglob

boites=()

# Boîte spool {{{1

# /var/spool/mail/$USER
# ou
# /var/mail/$USER

boites+=(/var/spool/mail/$USER)

# Boites mbox dans ~/racine/mail {{{1

cd ~/racine/mail

reps=(system theme list search archive)

for repertoire in $reps
do
	globe=(${repertoire}/**/*(.))
	boites+=("="$^globe)
done

# Boîtes maildir {{{1

boites+=("=procmail/save")

# Boites imap dans ~/racine/mail/imap {{{1

boites+=($(find ~/racine/mail/imap -type d -name cur | sort | sed -e 's:/cur/*$::' -e 's/ /\\ /g' | tr '\n' ' '))

# Usenet (plus ou moins boites MH) {{{1

cd ~/racine/news/spool/news

repertoires=($(find ~/racine/news/spool/news -type d | sort))

groupes=()

for candidat in $=repertoires
do
	# Le répertoire doit contenir des fichiers
	# pour être considéré comme une boîte aux lettres
	fichiers=($candidat/*(.))
	Nfichiers=${#fichiers}
	if (( Nfichiers == 0 ))
	then
		continue
	fi
	#echo $Nfichiers $repertoire
	groupes+=($candidat)
done

boites+=($groupes)

# Saved {{{2

boites+=($(find ~/racine/news/saved -type f | sort))

# Final {{{1

echo -n $=boites
