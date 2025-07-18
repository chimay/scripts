#! /usr/bin/env sh
# =====================================================================
# zshrun 0.01 -- X11 application launcher based on zsh
# Copyright (C) 2010 Alecksey Pavlenko <divine.raven@gmail.com>
# Original idea: Henning Bekel <h.bekel@googlemail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#
# =====================================================================
#export ZDOTDIR=/home/diraven/sys/zshrunrc/
#urxvt -title urxvt_zshrun -geometry 72x1 -e sh -c " zsh -t -i -d"

#urxvt -title urxvt_zshrun -geometry 72x50 -e sh -c " zsh"
# ---------------------------------------------------------------------

export ZDOTDIR=$HOME/racine/config/shell/zsh/zshrunterm
export RACINE_ZSH=$HOME/racine/config/shell/zsh

urxvtc -name zshrunterm -geometry 84x7+200+200 \
	-e zsh -t -i -d
