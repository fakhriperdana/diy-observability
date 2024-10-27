#!/bin/bash

# Define threshold for failed SSH attempts
THRESHOLD=10

# Count the number of failed SSH login attempts and get the trace ID
FAILED_ATTEMPTS=$(wc -l /tmp/failed_ssh_attempts.log | awk '{print $1}')
TRACE_ID=$(tail -n 1 /tmp/failed_ssh_attempts.log | awk '{print $1}')

if [ "$FAILED_ATTEMPTS" -ge "$THRESHOLD" ]; then
    echo "Too many failed SSH login attempts ($FAILED_ATTEMPTS). Trace ID: $TRACE_ID" | mail -s "Security Alert: Failed SSH Logins" fakhriperdana.tech@gmail.com
    echo "Alert sent for failed SSH attempts. Trace ID: $TRACE_ID"
else
    echo "No alerts. Failed SSH attempts below threshold."
fi