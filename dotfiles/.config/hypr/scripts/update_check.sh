#!/bin/bash

# Check for available updates
updates=$(checkupdates)

# Count the number of updates by counting the lines of output
count=$(echo "$updates" | wc -l)

# Check if the number of updates is greater than zero
if [ "$count" -gt 0 ]; then
    # If updates are available, send a notification with the count
    notify-send "System Updates Available" "$count packages need to be updated."
else
    # If no updates are available, send a "no updates" notification
    notify-send "System Up-to-Date" "Your system has no pending updates."
fi
