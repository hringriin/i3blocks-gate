#!/bin/bash 
# author: hringriin

#temp=$(sensors | grep "^CPU" | awk '{print $2}' | tr -d "+" )
#
#echo -e " $temp"

core0=$(sensors | grep "Core 0" | sed -e 's/  */|/g' | cut -d "|" -f 3 | sed -e 's/+//g')
core1=$(sensors | grep "Core 1" | sed -e 's/  */|/g' | cut -d "|" -f 3 | sed -e 's/+//g')
temp1=$(sensors | grep "temp1" | sed -e 's/  */|/g' | cut -d "|" -f 2 | sed -e 's/+//g')
fan1=$(sensors | grep "fan1" | sed -e 's/  *//g' | cut -d ":" -f 2 | sed -e 's/+//g' | sed -e 's/R/ R/g')

echo " C0: ${core0} |  C1: ${core1} |  T1: ${temp1}"
