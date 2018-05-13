#!/bin/bash 
# disk - outputs the disc space of a (mounted) volume
# author: hringriin 

diskColor='<span color="limegreen"><b>'
endColor='</b></span>'

if [[ $# -lt 1 ]] ; then
    $0 -r /boot
fi

function getUsed ()
{
    echo `df -h $1 | tail -n 1 | sed -e 's/  */|/g' | cut -d "|" -f 3`
}

function getFree ()
{
    echo `df -h $1 | tail -n 1 | sed -e 's/  */|/g' | cut -d "|" -f 4`
}

function getAvail ()
{
    echo `df -h $1 | tail -n 1 | sed -e 's/  */|/g' | cut -d "|" -f 2`
}

function getPercUsed ()
{
    echo `df -h $1 | tail -n 1 | sed -e 's/  */|/g' | cut -d "|" -f 5 | sed -e 's/\%//g'`
}

while getopts "fhru" opt; do
    case $opt in
        f)
            if [[ $# -lt 2 || $# -gt 2 ]] ; then
                echo "No argument given."
                exit 127
            fi

            if [[ `getPercUsed $2` -gt 75 ]] ; then
                diskColor='<span color="yellow"><b>'
            elif [[ `getPercUsed $2` -gt 90 ]] ; then
                diskColor='</b><span color="red">'
            fi

            echo -e "${diskColor}`getUsed $2`${endColor} <span color='cyan'><b>/</b></span> `getAvail $2` (${diskColor}`getPercUsed $2`%${endColor})"
            ;;
        h)
            # displays all flags (help)
            echo ""
            echo "Usage:"
            echo "    disk [OPTIONS]"
            echo ""
            echo "Valid options are:"
            echo "    -f"
            echo "        It displays the used, the total available and currently available amount of space."
            echo ""
            echo "    -h"
            echo "        Print this help."
            echo ""
            echo "    -p"
            echo "        Percentage used."
            echo ""
            echo "    -r"
            echo "        Displays the remaining amount of space."
            echo ""
            echo "    -u"
            echo "        Displays the used amount of space."

            exit 0
            ;;
        r)
            if [[ $# -lt 2 || $# -gt 2 ]] ; then
                echo "No argument given."
                exit 127
            fi

            if [[ `getPercUsed $2` -gt 75 ]] ; then
                diskColor='<span color="yellow"><b>'
            elif [[ `getPercUsed $2` -gt 90 ]] ; then
                diskColor='</b><span color="red">'
            fi

            echo "${diskColor}`getFree $2`${endColor}"
            ;;
        u)
            if [[ $# -lt 2 || $# -gt 2 ]] ; then
                echo "No argument given."
                exit 127
            fi

            if [[ `getPercUsed $2` -gt 75 ]] ; then
                diskColor='<span color="yellow"><b>'
            elif [[ `getPercUsed $2` -gt 90 ]] ; then
                diskColor='</b><span color="red">'
            fi

            echo -e "${diskColor}`getUsed $2`${endColor}"
            ;;
        \?)
            #echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            #echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done


exit 0
