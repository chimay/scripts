#! /usr/bin/env sh

cd ~/racine/plugin/source

[[ -d modalka ]] || {

	echo "git clone https://github.com/mrkkrp/modalka"

	git clone https://github.com/mrkkrp/modalka
}

[[ -d origami.el ]] || {

	echo "git clone https://github.com/gregsexton/origami.el.git"

	git clone https://github.com/gregsexton/origami.el.git
}

[[ -d persp-mode.el ]] || {

	echo "git clone https://github.com/Bad-ptr/persp-mode.el.git"

	git clone https://github.com/Bad-ptr/persp-mode.el.git
}

[[ -d xah-math-input ]] || {

	echo "git clone https://github.com/xahlee/xah-math-input"

	git clone https://github.com/xahlee/xah-math-input
}
