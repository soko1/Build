#!/bin/bash

for card in /sys/class/sound/card*; do

  chip=$(amixer -c 0 info | grep "Mixer name" | awk -F": " '{print (substr($2, 2, length($2) - 2))}')
  acard=$(cat /proc/asound/cards | grep "$(cat $card/number) \[$(cat $card/id)" | awk -F" - " '{print $2}')
  case $acard in
    "HDA Intel PCH" )
      case $chip in 
        "Realtek ALC283" )
          echo "Unmute / Mute SPDIF Output for the sound card"
          echo "-----------------------------"
          /usr/bin/amixer -c 0 set IEC958,16 unmute
          ;;
        "Realtek ALC892" )
          /usr/bin/amixer -c 0 set Front,0 mute
          /usr/bin/amixer -c 0 set Surround,0 mute
          /usr/bin/amixer -c 0 set Center,0 mute
          /usr/bin/amixer -c 0 set LFE,0 mute
          /usr/bin/amixer -c 0 set IEC958,16 unmute
          ;;
        "IDT 92HD81B1X5" )
          ;;
      esac
        ;;
  esac
done









