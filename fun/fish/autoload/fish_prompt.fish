# vim: set filetype=sh:

function fish_prompt --description 'Write out the prompt'
	set -l suffix
	switch "$USER"
		case root toor
			set suffix '#'
		case '*'
			set suffix '$'
	end
	echo
	echo -s " +--- $USER @ " (prompt_hostname) " : " (pwd)
	echo -s " |"
	echo -n -s	' +--- ' (date +%H:%M) " $suffix "
end
