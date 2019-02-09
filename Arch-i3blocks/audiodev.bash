#!/bin/bash
# audiodev - change audio device by pactl

# button handling
if [[ $1 == "1" ]] ; then
    # default device (internal)
    pactl set-card-profile alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 off
    pactl set-card-profile alsa_card.pci-0000_01_00.1 off
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo+input:analog-stereo
    urxvt -name "PULSEAUDIO" -e ~/Repositories/github.com/hringriin/dotfiles/repo/pulseaudio/controlVolume.zsh setOutDev
fi

if [[ $1 == "2" ]] ; then
    # VoIP device (Headset, Logitech G933)
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 off
    pactl set-card-profile alsa_card.pci-0000_01_00.1 off
    pactl set-card-profile alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 output:analog-stereo+input:analog-mono
    urxvt -name "PULSEAUDIO" -e ~/Repositories/github.com/hringriin/dotfiles/repo/pulseaudio/controlVolume.zsh setOutDev
fi

if [[ $1 == "3" ]] ; then
    # VoIP device (Headset, Logitech G933)
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 off
    pactl set-card-profile alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 off
    pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
    urxvt -name "PULSEAUDIO" -e ~/Repositories/github.com/hringriin/dotfiles/repo/pulseaudio/controlVolume.zsh setOutDev
fi

tcolor=\#8ec07c
devPath=${HOME}/.local/share/pulseaudiodevicechooser            # path to config folder
devname=`cat ${devPath}/outdev`
dname="Errör"


if [[ ${devname} == *"pci-0000_00_1b.0"* ]] ; then
    dname="Internal"
elif [[ ${devname} == *"Logitech_Logitech_G933_Gaming_Wireless_Headset"* ]] ; then
    dname="Logitech G933"
elif [[ ${devname} == *"pci-0000_01_00.1"* ]] ; then
    dname="Samsung TV"
else
    dname="Unknown"
fi

echo "<span color=\"${tcolor}\">${dname}</span>"
