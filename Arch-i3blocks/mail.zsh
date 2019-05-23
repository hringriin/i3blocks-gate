#!/bin/zsh
# mail - outputs number of new mails

# declare variables {{{

# number of mails
mails=0

# tmp array
mailarr=()

# dir of my mails
maildir=${HOME}/.mailfolder

# declare variables }}}

# go through every folder in the maildir called 'new' to search for new
# mails and add each number of new mails to the array
ls -R ${maildir} | \
    grep /new | \
    tr -d ':' | \
    while read i ; do
        mailarr+=($(find "$i" -type f | wc -l))
    done

# iterate through the array and sum the numbers
for var in ${mailarr[@]} ; do
    mails=$((mails + ${var}))
done


if [[ ${mails} -gt 30 ]] ; then
    color=\#fb4934
    envel=
elif [[ ${mails} -gt 0 ]] ; then
    color=\#fabd2f
    envel=
elif [[ ${mails} -eq 0 ]] ; then
    color=\#8ec07c
    envel=
else
    color=\#fb4934
    envel=ERROR
fi

diskColor="<span color=\"${color}\"><b>"
endColor="</b></span>"

echo "${envel}  ${diskColor}${mails}${endColor}"
