#!/bin/bash
# tider

raw=$(cat ${HOME}/.config/tider/i3bar.txt)
tstatus=$(echo ${raw} | tr -d '"{}' | cut -d " " -f 2)
tcolor=$(echo ${raw} | tr -d '"{}' | cut -d "," -f 2 | cut -d " " -f 3)
ttime=$(echo ${raw} | tr -d '"{}' | cut -d "," -f 1 | sed -e 's/.*TIME //' | cut -d " " -f 1)
tsubj=$(echo ${raw} | tr -d '"{}' | cut -d "," -f 1 | sed -e 's/.*TIME //g' | sed -e 's/ /|/' | cut -d "|" -f 2)

if [[ ${tcolor} == "#00AA00" ]] ; then
    tcolor=\#b8bb26
elif [[ ${tcolor} == "#DD6600" ]] ; then
    tcolor=\#fabd2f
else
    tcolor=\#ff00ff
fi

function test()
{
    echo -e "RAW DATA:  ${raw}"
    echo -e "Status:    ${tstatus}"
    echo -e "Color:     ${tcolor}"
    echo -e "Time:      ${ttime}"
    echo -e "Subject:   ${tsubj}"
}

if [[ $1 == "test" ]] ; then
    test
fi

# button handling
if [[ $1 == "1" ]] ; then
    tider call report > /dev/null
fi

if [[ $1 == "2" ]] ; then
    tider call target > /dev/null
fi

if [[ $1 == "3" ]] ; then
    tider call menu > /dev/null
fi

echo "<span color=\"${tcolor}\">${ttime} ${tstatus} ${tsubj}</span>"
