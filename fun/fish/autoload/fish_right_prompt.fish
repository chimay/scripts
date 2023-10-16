# vim: set filetype=sh:

function fish_right_prompt --description 'Write out the prompt'
	echo (date +"%d-%M-%Y") (tty)
end
