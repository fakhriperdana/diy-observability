#!/bin/bash

# In percent
THRESHOLD=80

# Get the current disk usage
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "Disk usage is critical: $DISK_USAGE%" | mail -s "[Disk Space Alert]" fakhriperdana.tech@gmail.com
    echo "Alert sent for high disk usage."
else
    echo "Disk usage is normal: $DISK_USAGE%"
fi
