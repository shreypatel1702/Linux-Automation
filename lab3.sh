#!/bin/bash

# Transfer configure-host.sh script to server1
scp configure-host.sh remoteadmin@server1-mgmt:/root

# Run configure-host.sh on server1
ssh remoteadmin@server1-mgmt -- /root/configure-host.sh -verbose -name loghost -ip 192.168.16.3 -hostentry webhost 192.168.16.4

# Transfer configure-host.sh script to server2
scp configure-host.sh remoteadmin@server2-mgmt:/root

# Run configure-host.sh on server2ssh remoteadmin@server2-mgmt -- /root/configure-host.sh -verbose -name webhost -ip 192.168.16.4 -hostentry loghost 192.168.16.3

# Update local /etc/hosts file
sudo ./configure-host.sh -verbose -hostentry loghost 192.168.16.3
sudo ./configure-host.sh -verbose -hostentry webhost 192.168.16.4
