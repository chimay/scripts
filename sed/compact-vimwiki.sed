#!/usr/bin/env -S sed -f

# vim:filetype=sed:nofoldenable:

# Double empty lines
# ------------------------------

: empty

/^$/ {
	n
	: loop-empty
	/^$/ {
		d
		b loop-empty
	}
}

# Plain lists
# ------------------------------

: list

/^\s*[-+*]/ {
	: loop-list
	s/^\s*\*/\t\t-/
	s/^\s*+/\t*/
	n
	/^$/ ! b loop-list
	h
	d
	/^\s*[-+*]/ b loop-list
	H
	s/.*//
	x
}
