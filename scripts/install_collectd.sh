#!/bin/bash

# Install collectd
sudo apt update
sudo apt install -y collectd

# Create a configuration file for collectd
cat <<EOF | sudo tee /etc/collectd/collectd.conf
Hostname "your-server"
Interval 10
LoadPlugin cpu
LoadPlugin memory
LoadPlugin interface
LoadPlugin disk
LoadPlugin network

<Plugin network>
    Server "monitoring-server-ip" "25826"
</Plugin>
EOF

# Restart collectd to apply the configuration
sudo systemctl restart collectd
sudo systemctl enable collectd

echo "Collectd installed and configured"
echo "Collecting metrics for CPU, memory, disk, and network."
