# vim: set filetype=sh :

# initialization {{{1

note='NONE'
racine=~/graphix

# arguments {{{1

while true
do
	case $1 in
		[0-9a-zA-Z])
			note=$1
			shift
			;;
		?*)
			racine=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# eval note format {{{1

# Minuscules ?
#note=${note:l}

# Majuscules ?
note=${note:u}

# current wallpaper {{{1

nom=`sed -n '/.*:.*:.*/p' ~/log/wallpaper.log | tail -n 1 `
nom=${nom##*:}
nom=${nom// }

# end {{{1

# echo "eve $note $nom"
# echo

eve $note $nom
