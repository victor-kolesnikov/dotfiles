#!/bin/bash
# Monitor configuration for i3wm
# Environment-aware monitor setup
# Save as: ~/.screenlayout/monitors-setup.sh

# Detect environment
if [ -f ~/.config/i3/detect-env.sh ]; then
    ENV=$(~/.config/i3/detect-env.sh 2>/dev/null || echo "laptop")
else
    ENV="laptop"
fi

case "$ENV" in
    tower)
        # Tower-5810 PC - 4 Monitor Setup
        # Monitors: DP-0 (left portrait), DP-5 (top), DP-6 (bottom primary), DP-2 (right portrait)
        
        # Reset all monitors
        xrandr --output DP-0 --off --output DP-2 --off \
               --output DP-5 --off --output DP-6 --off 2>/dev/null
        sleep 2
        
        # Configure all monitors with correct positions
        xrandr \
          --output DP-0 --mode 2560x1440 --pos 0x0 --rotate right \
          --output DP-5 --mode 1280x1024 --pos 1440x0 --rotate normal \
          --output DP-6 --mode 2560x1440 --pos 1440x1024 --rotate normal --primary \
          --output DP-2 --mode 2560x1440 --pos 4000x0 --rotate normal
        ;;
    
    laptop)
        # Laptop - Auto-detect and configure single monitor
        if command -v xrandr >/dev/null 2>&1; then
            # Get the first connected monitor
            PRIMARY=$(xrandr --query | grep " connected" | head -n1 | cut -d" " -f1)
            if [ -n "$PRIMARY" ]; then
                # Set as primary with auto mode
                xrandr --output "$PRIMARY" --auto --primary
            fi
        fi
        ;;
    
    wsl)
        # WSL - No monitor setup needed
        # WSLg handles display automatically
        exit 0
        ;;
    
    *)
        # Default to laptop behavior
        if command -v xrandr >/dev/null 2>&1; then
            PRIMARY=$(xrandr --query | grep " connected" | head -n1 | cut -d" " -f1)
            if [ -n "$PRIMARY" ]; then
                xrandr --output "$PRIMARY" --auto --primary
            fi
        fi
        ;;
esac

