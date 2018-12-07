#!/bin/bash

#Vol=$(amixer -c 0 get Master | grep "Mono:" | awk '{print $4}' | tr -d "[ %]")
#Mute=$(amixer -c 0 get Master | grep "Mono:" | awk '{print $6}' | tr -d "[-]")

if [[ $1 == "vol" ]] ; then
    Vol=$(pulsemixer --get-volume | awk '{print $1}')
    Mute=$(pulsemixer --get-mute)
elif [[ $1 == "mic" ]] ; then
    Vol=$(pulsemixer --id 1 --get-volume | awk '{print $1}')
    Mute=$(pulsemixer --id 1 --get-mute)
fi


if [[ "$Mute" -eq 1 ]] ; then
    echo -e "  Mute"
else
    if [ "$Vol" -gt "80" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "60" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "40" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "20" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -eq "0" ];then
        echo -e " $Vol %"
    fi
fi

unset Vol
unset Mute

pkill -RTMIN+12 i3blocks
