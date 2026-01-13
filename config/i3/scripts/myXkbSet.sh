#!/bin/bash

sleep 5
# two layouts
setxkbmap -layout us,jp -model pc105
# toggle the layouts by pressing alt on both side
setxkbmap -option "grp:alts_toggle" -model pc105
