#!/usr/bin/env sh

mini_vimpack=$HOME/racine/plugin/manager/vimpack/minpac/opt/minpac
mini_neovimpack=$HOME/racine/plugin/manager/neovimpack/minpac/opt/minpac

git clone https://github.com/k-takata/minpac.git $mini_vimpack
cp -R $mini_vimpack $mini_neovimpack
