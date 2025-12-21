#!/usr/bin/env bash
# Polybar launch script with monitor-specific configurations
# Save as: ~/.config/polybar/launch_polybar.sh

# Terminate existing instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Wait for monitors
sleep 1

# Launch on each monitor with appropriate bar
if type "xrandr" >/dev/null 2>&1; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        # Use smaller bar for DP-5 (Lenovo monitor)
        if [ "$m" = "DP-5" ]; then
            echo "Launching smaller polybar on $m"
            MONITOR=$m polybar --reload toph-small 2>&1 | tee -a /tmp/polybar-$m.log &
        else
            echo "Launching standard polybar on $m"
            MONITOR=$m polybar --reload toph 2>&1 | tee -a /tmp/polybar-$m.log &
        fi
    done
else
    polybar --reload toph &
fi
