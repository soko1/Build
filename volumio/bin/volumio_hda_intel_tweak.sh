#!/bin/bash

for card in /sys/class/sound/card*; do

  chip=$(cat /$card/hdaudio*/chip_name)
  acard=$(cat /proc/asound/cards | grep "$(cat $card/number) \[$(cat $card/id)")

  if [[ $acard =~ "HDA Intel PCH" ]]; then
    if [ $chip == "ALC283" ]; then
      echo "Unmute / Mute SPDIF Output for the sound card"
      echo "-----------------------------"
      /usr/bin/amixer -c 0 set IEC958,0 mute
      /usr/bin/amixer -c 0 set 'IEC958 Default PCM',0 mute
      /usr/bin/amixer -c 0 set IEC958,16 unmute
    fi
  fi
done




