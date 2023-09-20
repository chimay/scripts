#!/usr/bin/env sh

if [ -e "$1" ]; then
		cat $1 | tr '[:upper:]' '[:lower:]' | sed 's/th/ᚦ/g' | sed 's/ng/ᛜ/g' | sed 's/[kc]/ᚲ/g' | sed 's/[pw]/ᚹ/g' | sed 's/[jy]/ᛃ/g' | sed 's/a/ᚨ/g' | sed 's/b/ᛒ/g' | sed 's/d/ᛞ/g' | sed 's/e/ᛖ/g' | sed 's/f/ᚠ/g' | sed 's/g/ᚷ/g' | sed 's/h/ᚻ/g' | sed 's/i/ᛁ/g' | sed 's/l/ᛚ/g' | sed 's/m/ᛗ/g' | sed 's/n/ᚾ/g' | sed 's/o/ᛟ/g' | sed 's/p/ᛈ/g' | sed 's/r/ᚱ/g' | sed 's/s/ᛋ/g' | sed 's/t/ᛏ/g' | sed 's/u/ᚢ/g' | sed 's/z/ᛉ/g'
		exit
elif [ -z "$1" ]
	then read RAWTEXT
elif [ "$1" ]
	then RAWTEXT="$1"
elif [ -z "$1" ] && [ -z $RAWTEXT ]
	then echo "No text or file given" && exit
fi

echo $RAWTEXT | tr '[:upper:]' '[:lower:]' | sed 's/th/ᚦ/g' | sed 's/ng/ᛜ/g' | sed 's/[kc]/ᚲ/g' | sed 's/[vw]/ᚹ/g' | sed 's/[jy]/ᛃ/g' | sed 's/a/ᚨ/g' | sed 's/b/ᛒ/g' | sed 's/d/ᛞ/g' | sed 's/e/ᛖ/g' | sed 's/f/ᚠ/g' | sed 's/g/ᚷ/g' | sed 's/h/ᚻ/g' | sed 's/i/ᛁ/g' | sed 's/l/ᛚ/g' | sed 's/m/ᛗ/g' | sed 's/n/ᚾ/g' | sed 's/o/ᛟ/g' | sed 's/p/ᛈ/g' | sed 's/r/ᚱ/g' | sed 's/s/ᛋ/g' | sed 's/t/ᛏ/g' | sed 's/u/ᚢ/g' | sed 's/z/ᛉ/g'


exit
