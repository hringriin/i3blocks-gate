#!/bin/bash 
# lang - displays keyboard layout
# author: hringriin 

layout=$(setxkbmap -query | grep -i layout | sed -e 's/  *//g' | cut -d ":" -f 2)
variant=$(setxkbmap -query | grep -i variant | sed -e 's/  *//g' | cut -d ":" -f 2)

if [[ -z ${variant} ]] ; then
    echo "  <b><span color=\"#8ec07c\">${layout}</span></b>"
else
    echo "  <b><span color=\"#8ec07c\">${layout}_${variant}</span></b>"
fi
