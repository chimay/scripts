#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

menu=( \
	"Exécuter une commande tmux" \
	"Historique des commandes tmux" \
	"Visualiser le contenu du pane dans un pager" \
	"Charger une session" \
	"Annuler" \
)

choix=$( \
	print -l $menu | fzf --prompt='tmux> '
)

case $choix in

	"Exécuter une commande tmux")
		exec ~/racine/shell/dialog/fzf-tmux-command.zsh
		;;
	"Historique des commandes tmux")
		exec ~/racine/shell/dialog/fzf-tmux-history.zsh
		;;
	"Visualiser le contenu du pane dans un pager")
		tmux send-keys "tmux capture-pane -S - -p | less" Enter
		;;
	"Charger une session")
		exec ~/racine/shell/dialog/fzf-tmux-session.zsh
		;;
	"Annuler")
		exit 0
		;;
esac
