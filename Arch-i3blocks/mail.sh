#!/bin/bash
# mail - outputs number of new mails

maildir="${HOME}/.mailfolder"
mboxes="${maildir}/*/Inbox/new ${maildir}/*/Spam/new"
mails=$(ls -1 ${mboxes} | grep -v new | sed '/^$/d' | wc -l)
color=
envel=

if [[ ${mails} -gt 20 ]] ; then
    color=\#fb4934
    envel=
elif [[ ${mails} -gt 0 ]] ; then
    color=\#fabd2f
    envel=
else
    color=\#b8bb26
    envel=
fi

diskColor="<span color=\"${color}\"><b>"
endColor="</b></span>"

echo "${envel}  ${diskColor}${mails}${endColor}"
