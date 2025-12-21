#!/bin/bash
# Monitor configuration for i3wm
# Save as: ~/.screenlayout/monitors-setup.sh

# Reset all monitors
xrandr --output DP-0 --off --output DP-2 --off \
       --output DP-5 --off --output DP-6 --off
sleep 2

# Configure all monitors with correct positions
xrandr \
  --output DP-0 --mode 2560x1440 --pos 0x0 --rotate right \
  --output DP-5 --mode 1280x1024 --pos 1440x0 --rotate normal \
  --output DP-6 --mode 2560x1440 --pos 1440x1024 --rotate normal --primary \
  --output DP-2 --mode 2560x1440 --pos 4000x0 --rotate left

