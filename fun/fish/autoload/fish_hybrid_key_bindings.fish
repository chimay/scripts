# vim: set filetype=sh:

function fish_hybrid_key_bindings --description \
	"Vi-style bindings that inherit emacs-style bindings in all modes"
	for mode in default insert visual
		fish_default_key_bindings -M $mode
	end
	fish_vi_key_bindings --no-erase
	set -U fish_cursor_default block
	set -U fish_cursor_visual block
	set -U fish_cursor_insert line
	set -U fish_cursor_replace_one underscore
end
