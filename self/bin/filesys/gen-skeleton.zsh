#!env zsh

# vim: set filetype=zsh:

script=~/racine/self/bin/filesys/skeleton.sh

# En-tête {{{1

echo "#!/usr/bin/env zsh" >| $script

{
	echo
	echo "# vim: set filetype=sh:"
	echo
	echo 'niveau=${1:-4}'
	echo
	echo "[ -d ~/graphix ] || echo mkdir ~/graphix"
	echo "[ -d ~/graphix ] || mkdir ~/graphix"
	echo
	echo "[ -d ~/photo ] || echo mkdir ~/photo"
	echo "[ -d ~/photo ] || mkdir ~/photo"
	echo
	echo "[ -d ~/audio ] || echo mkdir ~/audio"
	echo "[ -d ~/audio ] || mkdir ~/audio"
	echo
	echo "[ -d ~/mount ] || echo mkdir ~/mount"
	echo "[ -d ~/mount ] || mkdir ~/mount"
	echo
	echo "[ -d ~/log ] || echo mkdir ~/log"
	echo "[ -d ~/log ] || mkdir ~/log"
	echo
	echo "[ -d ~/run ] || echo mkdir ~/run"
	echo "[ -d ~/run ] || mkdir ~/run"
	echo
	echo "[ -d ~/racine ] || echo mkdir ~/racine"
	echo "[ -d ~/racine ] || mkdir ~/racine"
	echo
	echo 'echo "[ niveau -gt 0 ] || exit 0"'
	echo '[ $niveau -gt 0 ] || exit 0'
	echo

} >> $script

# Vers graphix {{{1

{
	echo "echo cd ~/graphix"
	echo "cd ~/graphix"
	echo

} >> $script

# Dossiers dans graphix {{{1

{
	cd ~/graphix

	for dossier in **/*(/)
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir $dossier"
		echo "[ -d $dossier ] || mkdir $dossier"
	done

	echo

} >> $script

# Vers mount {{{1

{
	echo "echo cd ~/mount"
	echo "cd ~/mount"
	echo

} >> $script

# Dossiers dans mount {{{1

{
	cd ~/mount

	for dossier in **/*(/)
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir $dossier"
		echo "[ -d $dossier ] || mkdir $dossier"
	done

	echo

} >> $script

# Vers log {{{1

{
	echo "echo cd ~/log"
	echo "cd ~/log"
	echo

} >> $script

# Dossiers dans log {{{1

{
	cd ~/log

	for dossier in **/*(/)
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir $dossier"
		echo "[ -d $dossier ] || mkdir $dossier"
	done

	echo

} >> $script

# Vers run {{{1

{
	echo "echo cd ~/run"
	echo "cd ~/run"
	echo

} >> $script

# Dossiers dans run {{{1

{
	cd ~/run

	for dossier in **/*(/)
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir $dossier"
		echo "[ -d $dossier ] || mkdir $dossier"
	done

	echo

} >> $script

# Vers Racine {{{1

{
	echo "echo cd ~/racine"
	echo "cd ~/racine"
	echo

} >> $script

# Dossiers de niveau 1 {{{1

{
	cd ~/racine

	for dossier in *(/)
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir $dossier"
		echo "[ -d $dossier ] || mkdir $dossier"
	done

	echo
	echo 'echo "[ niveau -gt 1 ] || exit 0"'
	echo '[ $niveau -gt 1 ] || exit 0'
	echo

} >> $script

# Dossiers de niveau 2 {{{1

{
	find . -mindepth 2 -maxdepth 2 -type d | \
		grep -v .git | \
		grep -v .hg | \
		grep -v .bzr | \
		grep -v _darcs \
	| while read dossier
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir -p $dossier"
		echo "[ -d $dossier ] || mkdir -p $dossier"
	done

	echo
	echo 'echo "[ niveau -gt 2 ] || exit 0"'
	echo '[ $niveau -gt 2 ] || exit 0'
	echo

} >> $script

# Dossiers de niveau 3 {{{1

{
	find . -mindepth 3 -maxdepth 3 -type d | \
		grep -v .git | \
		grep -v .hg | \
		grep -v .bzr | \
		grep -v _darcs \
	| while read dossier
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir -p $dossier"
		echo "[ -d $dossier ] || mkdir -p $dossier"
	done

	echo
	echo 'echo "[ niveau -gt 3 ] || exit 0"'
	echo '[ $niveau -gt 3 ] || exit 0'
	echo

} >> $script

# Dossiers de niveau 4 {{{1

{
	find . -mindepth 4 -maxdepth 4 -type d | \
		grep -v .git | \
		grep -v .hg | \
		grep -v .bzr | \
		grep -v _darcs \
	| while read dossier
	do
		[[ $dossier =~ ' ' ]] && continue
		echo "[ -d $dossier ] || echo mkdir -p $dossier"
		echo "[ -d $dossier ] || mkdir -p $dossier"
	done

} >> $script

# Rendre le script exécutable {{{1

chmod +x $script
