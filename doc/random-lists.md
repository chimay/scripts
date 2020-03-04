<!-- vim: set filetype=markdown: --!>

# Random list with priorities for music & wallpaper

These tools can help you build shuffled list for your music collection,
but they can also be used to change your wallpaper dynamically.

[random.zsh](https://github.com/chimay/scripts/blob/master/zsh/random.zsh)
produces numbers which look remotely like a normal random distribution.
The goal here is not to be precise, but to roughgly shuffle lists.
Its written in pure zsh, no need for python or another external random
generator.

[gen-random-list.zsh](https://github.com/chimay/scripts/blob/master/zsh/gen-random-list.zsh)
produces shuffled list while taking file priorities into account. The
priority is specified using the format [0-9A-Z]-* in the file name. It
uses basic unix tools.

Note : Using file tags to handle priorities would be much slower.

[wallpaper.zsh](https://github.com/chimay/scripts/blob/master/zsh/wallpaper.zsh)
dynamically change your wallpaper using `feh` and the previous scripts.
