#!/bin/sh
scrot --select -e 'xclip -selection clipboard -t image/png -i $f' -s ./.tmp.png
rm ./.tmp.png
