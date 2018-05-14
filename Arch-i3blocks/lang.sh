#!/bin/bash 
# lang - displays keyboard layout
# author: hringriin 

layout=`setxkbmap -query | grep -i layout | sed -e 's/  *//g' | cut -d ":" -f 2`
variant=`setxkbmap -query | grep -i variant | sed -e 's/  *//g' | cut -d ":" -f 2`

if [[ -z ${variant} ]] ; then
    echo "  ${layout}"
else
    echo "  ${layout}_${variant}"
fi
