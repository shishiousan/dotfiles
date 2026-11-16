#!/bin/bash
while xdotool search --class gnuplot >/dev/null 2>&1; do
  sleep 0.001
done
i3-msg "workspace back_and_forth"
