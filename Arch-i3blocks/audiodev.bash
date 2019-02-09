#!/bin/bash
# audiodev - change audio device by pactl

# button handling
if [[ $1 == "1" ]] ; then
    # default device (internal)
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo+input:analog-stereo
    pactl set-card-profile alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 off
fi

if [[ $1 == "2" ]] ; then
    # VoIP device (Headset, Logitech G933)
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 off
    pactl set-card-profile alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 output:analog-stereo+input:analog-mono
fi

tcolor=\#8ec07c
devPath=${HOME}/.local/share/pulseaudiodevicechooser            # path to config folder
devname=`cat ${devPath}/outdev`
dname="Errör"

if [[ ${devname} == *"pci-0000_00_1b.0"* ]] ; then
    dname="Internal"
elif [[ ${devname} == *"Logitech_Logitech_G933_Gaming_Wireless_Headset"* ]] ; then
    dname="Logitech G933"
else
    dname="Unknown"
fi

echo "<span color=\"${tcolor}\">${dname}</span>"
