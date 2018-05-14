#!/bin/bash

# Show Wifi Stuff
W_inter=$(ip link | grep "[1-9]: wlp" | cut -d " " -f2 | tr -d ':')
W_con=$(nmcli d | grep "$W_inter" | awk '{print $3}')
W_name=$(nmcli d | grep "$W_inter" | awk '{print $4}')
# modified by: @hringriin
W_ip=$(ifconfig $W_inter | grep 'netmask' | awk '{print $2}')

# author: @hringriin
W_str=$(grep ${W_inter} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

# Show Ethernet stuff
E_inter=$(ip link | grep "^[1-9]: enp" | cut -d " " -f2 | tr -d :)
E_con=$(nmcli d | grep "$E_inter" | awk '{print $3}')
E_name=$(nmcli d | grep "$E_inter" | awk '{print $4}')
# modified by: @hringriin
E_ip=$(ifconfig $E_inter | grep 'netmask' | awk '{print $2}')

# author: @hringriin
# Show WWAN stuff
L_inter=$(ip link| grep "[1-9]: wwp" | cut -d " " -f 2 | tr -d ':')        # this seems not to work with my system. the device is called ttyACM0 in nmcli but wwp... in iplink
L_con=$(nmcli d | grep "ttyACM0" | awk '{print $3}')
L_name=$(nmcli d | grep "ttyACM0" | awk '{print $4}')
L_ip=$(ifconfig "${L_inter}" | grep 'netmask' | awk '{print $2}')

# author: @hringriin
diskColor='<span color="limegreen"><b>'
endColor='</b></span>'

# author: @hringriin
WWAN ()
{
    if [ "$L_con" = "connected" ];then
        echo -e "${diskColor}$L_name: $L_ip${endColor}"
    else
        echo " "    # to have the label displayed
    fi
}

# modified by: @hringriin
Wifi ()
{
    if [ "$W_con" = "connected" ];then
        if [[ ${W_str} -lt 50 ]] ; then
            diskColor='<span color="red"><b>'
        elif [[ ${W_str} -lt 70 ]] ; then
            diskColor='<span color="yellow"><b>'
        fi
        echo -e "${diskColor}$W_name: $W_ip ($W_str%)${endColor}"
    else
        echo " "    # to have the label displayed
    fi
}

# modified by: @hringriin
Ethernet ()
{
    if [ "$E_con" = "connected" ];then
        echo -e "${diskColor}$E_name: $E_ip${endColor}"
    else
        echo " "    # to have the label displayed
    fi
}

case "$1" in
    "-w" )
        Wifi
    ;;
    "-e" )
        Ethernet
    ;;
    # author: @hringriin
    "-l")
        WWAN
    ;;
    * )
        # modified by: @hringriin
        echo -e " $0 : no Argument \n\t -e : Show Ethernet \n\t -w : Show Wireless \n\t -l : Show WWAN"
    ;;
esac

