#!/bin/bash

# Define the log file to parse
LOG_FILE="/var/log/auth.log"

# Generate a trace ID and parse failed SSH login attempts with trace ID
TRACE_ID=$(uuidgen)
grep "Failed password" $LOG_FILE | while read -r line ; do
    echo "$TRACE_ID $line" >> /tmp/failed_ssh_attempts.log
done

# Generate a new trace ID for sudo commands
TRACE_ID=$(uuidgen)
grep "sudo" $LOG_FILE | while read -r line ; do
    echo "$TRACE_ID $line" >> /tmp/sudo_commands.log
done

# Extract all error messages and assign trace IDs
TRACE_ID=$(uuidgen)
grep -i "error" /var/log/syslog | while read -r line ; do
    echo "$TRACE_ID $line" >> /tmp/system_errors.log
done

echo "Log parsing with tracing completed. Check /tmp/ for the results with trace IDs."