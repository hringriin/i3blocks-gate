#!/bin/bash

# just a test

# Show Wifi Stuff
W_inter=$(ip link | grep "[1-9]: wlp" | cut -d " " -f2 | tr -d ':')
W_con=$(nmcli d | grep "$W_inter" | awk '{print $3}')
W_name=$(nmcli d | grep "$W_inter" | awk '{print $4}')
# modified by: @hringriin
W_ip=$(ip -br addr | grep "${W_inter}" | awk '{print $3}')

# author: @hringriin
if [[ ${W_inter} >/dev/null ]] ; then
    W_str=$(grep ${W_inter} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
fi


# Show Ethernet stuff
E_inter=$(ip link | grep "^[1-9]: enp" | cut -d " " -f2 | tr -d :)
E_con=$(nmcli d | grep "$E_inter" | awk '{print $3}')
E_name=$(nmcli d | grep "$E_inter" | awk '{print $4}')
# modified by: @hringriin
E_ip=$(ip -br addr | grep "${E_inter}" | awk '{print $3}')

# author: @hringriin
# Show WWAN stuff
L_inter=$(ip link| grep "[1-9]: wwp" | cut -d " " -f 2 | tr -d ':')        # this seems not to work with my system. the device is called ttyACM1 in nmcli but wwp... in iplink
L_con=$(nmcli d | grep "ttyACM" | awk '{print $3}')
L_name=$(nmcli d | grep ttyACM | awk '{$1="" ; $2="" ; $3="" ; print $0;}' | sed -e 's/^[ \t]*//')
L_ip=$(ip -br addr | grep "${L_inter}" | awk '{print $3}')


# author: @hringriin
diskColor="<span color=\"#8ec07c\"><b>"
endColor="</b></span>"

# author: @hringriin
WWAN ()
{
    if [ "$L_con" = "connected" ];then
        echo -e "${diskColor}$L_name: $L_ip${endColor}"
    else
        diskColor="<span color=\"#fabd2f\"><b>"
        echo "${diskColor}${L_con}${endColor}"    # to have the label displayed
    fi
}

# modified by: @hringriin
Wifi ()
{
    if [ "$W_con" = "connected" ];then
        if [[ ${W_str} -lt 50 ]] ; then
            diskColor="<span color=\"#fb4934\"><b>"
        elif [[ ${W_str} -lt 70 ]] ; then
            diskColor="<span color=\"#fabd2f\"><b>"
        fi
        echo -e "${diskColor}$W_name:${endColor} $W_ip ${diskColor}($W_str%)${endColor}"
    else
        diskColor="<span color=\"#fabd2f\"><b>"
        echo "${diskColor}${W_con}${endColor}"    # to have the label displayed
    fi
}

# modified by: @hringriin
Ethernet ()
{
    if [ "$E_con" = "connected" ] ; then
        echo -e "${diskColor}$E_name: $E_ip${endColor}"
    else
        diskColor="<span color=\"#fabd2f\"><b>"
        echo "${diskColor}${E_con}${endColor}"    # to have the label displayed
    fi
}

while getopts "elw" opt ; do
    case $opt in
        w)
            Wifi
        ;;
        e)
            Ethernet
        ;;
        # author: @hringriin
        l)
            WWAN
        ;;
    esac
done

exit 0
