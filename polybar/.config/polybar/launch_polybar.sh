#!/usr/bin/env bash
# Polybar launch script with environment-aware configurations
# Save as: ~/.config/polybar/launch_polybar.sh

# Detect environment
if [ -f ~/.config/i3/detect-env.sh ]; then
    ENV=$(~/.config/i3/detect-env.sh 2>/dev/null || echo "tower")
else
    ENV="tower"
fi

# WSL - Skip polybar (no X11 display typically)
if [ "$ENV" = "wsl" ]; then
    exit 0
fi

# Export environment marker for config file
# Config file uses this to select appropriate bar sections
export POLYBAR_ENV="$ENV"

# Terminate existing instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Wait for monitors
sleep 1

# Launch on each monitor with appropriate bar
# Bar names are environment-specific: toph-{env} or toph-small-{env}
if type "xrandr" >/dev/null 2>&1; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        case "$ENV" in
            tower)
                # Tower: Use smaller bar for DP-5 (Lenovo monitor), standard for others
                if [ "$m" = "DP-5" ]; then
                    BAR_NAME="toph-small-tower"
                    echo "Launching $BAR_NAME on $m"
                else
                    BAR_NAME="toph-tower"
                    echo "Launching $BAR_NAME on $m"
                fi
                ;;
            laptop|*)
                # Laptop: Launch standard polybar on single monitor
                BAR_NAME="toph-laptop"
                echo "Launching $BAR_NAME on $m"
                ;;
        esac
        MONITOR=$m polybar --reload "$BAR_NAME" 2>&1 | tee -a /tmp/polybar-$m.log &
    done
else
    # Fallback if xrandr is not available
    BAR_NAME="toph-${ENV:-tower}"
    polybar --reload "$BAR_NAME" &
fi
