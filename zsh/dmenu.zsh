# vim: set filetype=zsh:

lines=${1:-30}
shift
dmenu -b -l $lines -nb black -nf '#5b3c11' -sb '#5b3c11' -sf black $*
