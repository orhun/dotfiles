#!/usr/bin/env bash
# Plays a random MOD file from https://modarchive.org
# Depends on XMP (http://xmp.sourceforge.net/)
# https://gist.github.com/orhun/eda9701e357b625c2bada19563872715

rand=$(shuf -i 1-189573 -n 1)
tmp=$(mktemp /tmp/${rand}.XXXXXXXX.mod)
curl https://modarchive.org/jsplayer.php?moduleid=${rand} >${tmp}
xmp ${tmp}
rm ${tmp}
