#! /usr/bin/env sh

# vim: set fdm=indent:

cd ~/racine/source

[[ -d base16-shell ]] || {

	echo "git clone https://github.com/chriskempson/base16-shell.git"

	git clone https://github.com/chriskempson/base16-shell.git
}

[[ -d bookmarks ]] || {

	echo "git clone https://github.com/joajfreitas/bookmarks.git"

	git clone https://github.com/joajfreitas/bookmarks.git
}

[[ -d Buku ]] || {

	echo "git clone https://github.com/jarun/Buku.git"

	git clone https://github.com/jarun/Buku.git
}

[[ -d buku_run ]] || {

	echo "git clone https://github.com/carnager/buku_run.git"

	git clone https://github.com/carnager/buku_run.git
}

[[ -d cssc ]] || {

	echo "git clone git://git.savannah.gnu.org/cssc.git"

	git clone git://git.savannah.gnu.org/cssc.git
}

[[ -d emacs ]] || {

	echo "git clone git://git.savannah.gnu.org/emacs.git"

	git clone git://git.savannah.gnu.org/emacs.git
}

[[ -d global ]] || {

	echo "cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/sources/global co global"

	cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/sources/global co global
}

[[ -d idutils ]] || {

	echo "git clone git://git.savannah.gnu.org/idutils.git"

	git clone git://git.savannah.gnu.org/idutils.git
}

[[ -d neovim ]] || {

	echo "git clone https://github.com/neovim/neovim.git"

	git clone https://github.com/neovim/neovim.git
}

[[ -d neovim-qt ]] || {

	echo "git clone https://github.com/equalsraf/neovim-qt.git"

	git clone https://github.com/equalsraf/neovim-qt.git
}

[[ -d pico-read-speaker ]] || {

	echo "git clone https://github.com/GwadaLUG/pico-read-speaker"

	git clone https://github.com/GwadaLUG/pico-read-speaker
}

[[ -d qutebrowser ]] || {

	echo "git clone https://github.com/qutebrowser/qutebrowser.git"

	git clone https://github.com/qutebrowser/qutebrowser.git
}

[[ -d sc-im ]] || {

	echo "git clone https://github.com/andmarti1424/sc-im"

	git clone https://github.com/andmarti1424/sc-im
}

[[ -d vim ]] || {

	echo "git clone https://github.com/vim/vim.git"

	git clone https://github.com/vim/vim.git
}

[[ -d vit ]] || {

	echo "git clone https://github.com/scottkosty/vit.git"

	git clone https://github.com/scottkosty/vit.git
}

[[ -d xd-home-code ]] || {

	echo "coucou"
	echo "git clone git://git.code.sf.net/p/xd-home/code xd-home-code"

	git clone git://git.code.sf.net/p/xd-home/code xd-home-code
}
