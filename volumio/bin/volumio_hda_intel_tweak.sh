#!/bin/bash

for card in /sys/class/sound/card*; do
  cardno=$(cat $card/number)
  chip=$(amixer -c $cardno info | grep "Mixer name" | awk -F": " '{print (substr($2, 2, length($2) - 2))}')
  cardname=$(cat /proc/asound/cards | grep "$(cat $card/number) \[$(cat $card/id)" | awk -F" - " '{print $2}')
  case $cardname in
    "HDA Intel PCH" )
      case $chip in 
        "Realtek ALC283" )
          echo "Unmute / Mute SPDIF Output for the sound card"
          echo "-----------------------------"
          /usr/bin/amixer -c $cardno set IEC958,16 unmute
          ;;
        "Realtek ALC892" )
          /usr/bin/amixer -c $cardno set Front,0 mute
          /usr/bin/amixer -c $cardno set Surround,0 mute
          /usr/bin/amixer -c $cardno set Center,0 mute
          /usr/bin/amixer -c $cardno set LFE,0 mute
          /usr/bin/amixer -c $cardno set IEC958,16 unmute
          ;;
        "IDT 92HD81B1X5" )
          ;;
      esac
        ;;
  esac
done










