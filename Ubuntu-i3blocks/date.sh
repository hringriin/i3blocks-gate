#!/bin/bash 

echo -e "  $(date +%b%d\ %R) "

if [[ "$BLOCK_BUTTON" == "1" ]]; then
  if [ "$(pidof gsimplecal)" ]; then
    pkill gsimplecal
  else
    gsimplecal&
  fi
fi
