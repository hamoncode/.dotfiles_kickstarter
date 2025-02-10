#!/bin/bash

# Function to check if touchpad is active
is_touchpad_active() {
    xinput list --name-only | grep -i 'touchpad' | while read -r device; do
        xinput list-props "$device" | grep -q 'Device Enabled.*1' && return 0
    done
    return 1
}

# Start unclutter
unclutter -idle 1 -grab &

# Loop to monitor touchpad usage
while true; do
    if is_touchpad_active; then
        unclutter -grab &
    else
        killall unclutter
    fi
    sleep 1  # Check every second
done

