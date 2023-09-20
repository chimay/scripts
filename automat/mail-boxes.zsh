#! /usr/bin/env zsh

setopt nullglob

boites=()

# Boîte spool {{{1

# /var/spool/mail/$USER
# ou
# /var/mail/$USER

boites+=(/var/spool/mail/$USER)

# }}}1

# Boites mbox dans ~/racine/mail {{{1

cd ~/racine/mail

reps=(system theme list search archive)

for repertoire in $reps
do
	globe=(${repertoire}/**/*(.))

	boites+=("="$^globe)
done

# }}}1

# Boîtes maildir {{{1

boites+=("=procmail/save")

# }}}1

# Boites imap dans ~/racine/mail/imap {{{1

boites+=($(find ~/racine/mail/imap -type d -name cur | sort | sed -e 's:/cur/*$::' -e 's/ /\\ /g' | tr '\n' ' '))

# }}}1

echo -n $=boites
