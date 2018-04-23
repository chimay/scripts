#! /usr/bin/env python
# -*- coding: utf-8 -*-

# Importations {{{1

import sys, random

# }}}1

# Principal {{{1

def principal(arguments) :

    moyenne = 60

    dispersion = 30

    if len(arguments) > 2 :
        moyenne = float(arguments[1])
        dispersion = float(arguments[2])

    aleatoire = random.gauss(moyenne, dispersion)

    print(aleatoire)

# }}}1


# Main {{{1

if __name__ == '__main__' :

	principal(sys.argv)

# }}}1
