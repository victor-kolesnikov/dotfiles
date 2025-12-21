#!/bin/bash
# Environment detection script for i3 configuration
# Detects environment based on hostname and system properties
# Returns: tower, laptop, or wsl

# Check if running in WSL first (takes precedence)
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
    echo "wsl"
    exit 0
fi

# Check for WSL_DISTRO_NAME environment variable
if [ -n "$WSL_DISTRO_NAME" ]; then
    echo "wsl"
    exit 0
fi

# Get hostname
HOSTNAME=$(hostname 2>/dev/null || echo "")

# Check for tower-5810 PC
if echo "$HOSTNAME" | grep -qi "tower-5810\|tower5810"; then
    echo "tower"
    exit 0
fi

# Default to laptop for other cases
echo "laptop"
exit 0

