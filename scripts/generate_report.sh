#!/bin/bash

REPORT_FILE="/var/reports/log_report_$(date +%F).txt"

# Header for the report
echo "Log Report for $(date +%F)" > $REPORT_FILE
echo "==========================" >> $REPORT_FILE

# Add a summary of failed SSH login attempts
echo "Failed SSH Login Attempts:" >> $REPORT_FILE
wc -l /tmp/failed_ssh_attempts.log >> $REPORT_FILE

# Add a summary of sudo command usage
echo "Sudo Commands Executed:" >> $REPORT_FILE
wc -l /tmp/sudo_commands.log >> $REPORT_FILE

# Add a summary of system errors
echo "System Errors:" >> $REPORT_FILE
wc -l /tmp/system_errors.log >> $REPORT_FILE

# Collect metrics from collectd
echo "System Metrics (via collectd):" >> $REPORT_FILE

# Extract CPU usage metrics from collectd
CPU_USAGE=$(tail -n 5 /var/log/collectd.log | grep cpu | awk '{print $6}')
echo "CPU Usage: $CPU_USAGE%" >> $REPORT_FILE

# Extract memory usage metrics from collectd
MEM_USAGE=$(tail -n 5 /var/log/collectd.log | grep memory | awk '{print $6}')
echo "Memory Usage: $MEM_USAGE%" >> $REPORT_FILE

# Extract disk usage metrics from collectd
DISK_USAGE=$(tail -n 5 /var/log/collectd.log | grep disk | awk '{print $6}')
echo "Disk Usage: $DISK_USAGE%" >> $REPORT_FILE

echo "Report generated: $REPORT_FILE"