#!/bin/bash
# author: @hringriin

# author: @hringriin
function getBat ()
{
    #echo $(acpi | grep "Battery $1" | cut -d " " -f 4 | tr -d "%,")
    design=$(cat /sys/class/power_supply/BAT$1/uevent | grep "POWER_SUPPLY_ENERGY_FULL_DESIGN=" | cut -d "=" -f 2)
    current=$(cat /sys/class/power_supply/BAT$1/uevent | grep "POWER_SUPPLY_ENERGY_FULL=" | cut -d "=" -f 2)
    capacity=$(cat /sys/class/power_supply/BAT$1/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d "=" -f 2)

    echo $( printf "%.2f" $(echo "scale=10;(${current}/${design})*${capacity}" | bc))
}

# author: @hringriin
function getAdapter ()
{
    echo $(acpi -a | cut -d " " -f 3)
}

# author: @hringriin
function getIcon ()
{
    batval=$(printf "%.0f" $2)

    if [[ $1 == "on-line" ]] ; then
        echo " "
    else
        if [[ ${batval} -lt 20 ]] ; then
            echo "  "
        elif [[ ${batval} -lt 40 ]] ; then
            echo "  "
        elif [[ ${batval} -lt 60 ]] ; then
            echo "  "
        elif [[ ${batval} -lt 80 ]] ; then
            echo "  "
        elif [[ ${batval} -gt 100 ]] ; then
            echo "  "
        fi
    fi
}

if [[ $# -lt 1 || $1 -gt 1 ]] ; then
    exit 0
fi

echo "$(getIcon $(getAdapter) $(getBat $1)) $(getBat $1)%"
