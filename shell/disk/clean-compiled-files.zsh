#! /usr/bin/env zsh

unsetopt no_match

fichiers=(
*.o
*.so
*.pyc
*.elc
*.zwc

*.aux
*.log
*.out
*.maf
*.toc
*.ptc*
*.mtc*
)

print ${~fichiers} | xargs -p rm -f
