#!/usr/bin/env /bin/zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

menu=( \
	"Exécuter une commande tmux" \
	"Historique des commandes tmux" \
	"Charger une session" \
	"Annuler" \
)

choix=$( \
	print -l $menu | \
	fzf --cycle --hscroll-off=100 --color=bw --prompt='tmux> ' \
)

case $choix in

	"Exécuter une commande tmux")
		exec ~/racine/shell/dialog/fzf-tmux-command.zsh
		;;
	"Historique des commandes tmux")
		exec ~/racine/shell/dialog/fzf-tmux-history.zsh
		;;
	"Charger une session")
		exec ~/racine/shell/dialog/fzf-tmux-session.zsh
		;;
	"Annuler")
		exit 0
		;;
esac
