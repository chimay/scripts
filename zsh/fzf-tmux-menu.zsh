#!/usr/bin/env /bin/zsh

menu=( \
	"Exécuter une commande tmux" \
	"Historique des commandes tmux" \
	"Charger une session" \
	"Annuler" \
)

choix=$( \
	print -l $menu | \
	fzf --cycle --reverse --hscroll-off=100 --color=bw \
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
