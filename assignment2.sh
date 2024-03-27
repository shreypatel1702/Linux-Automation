#!/bin/bash

# Network Interface Configuration
echo "WE WILL NOW CONFIGURE NETWORK CONFIGURATION"
echo "--------------------------------------------------------------------------------------------------------------------------------"
sudo bash -c 'cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses: [192.168.16.21/24]
      gateway4: 192.168.16.2
      nameservers:
        addresses: [192.168.16.2]
        search: [home.arpa, localdomain]
EOF'
sudo netplan apply

# Hosts File Update
echo "WE WILL NOW UPDATE /ETC/HOSTS FILE"
echo "-------------------------------------------------------------------------------------------------------------------------"
sudo sed -i '/192.168.16.21 server1/d' /etc/hosts
echo "192.168.16.21 server1" | sudo tee -a /etc/hosts >/dev/null

# Software Installation
echo "WE WILL NOW INSTALL APACHE AND SQUID "
echo "---------------------------------------------------------------------------------------------------------------------------------"
sudo apt update
sudo apt install -y apache2 squid
if [ $? -ne 0 ]; then
    echo "Error: Failed to install Apache and Squid."
    exit 1
fi

# Firewall Configuration
echo "WE WILL NOW SET UP THE UFW FIREWALL"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow 3128/tcp
sudo ufw enable
if [ $? -ne 0 ]; then
    echo "Error: Failed to enable UFW firewall."
    exit 1
fi

# User Account Management
echo "WE WILL NOW CREATE THE USER ACCOUNTS "
echo "--------------------------------------------------------------------------------------------------------------------------------------"
users=("dennis" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")
for user in "${users[@]}"; do
    sudo adduser --gecos "" --disabled-password "$user"
    if [ "$user" = "dennis" ]; then
        sudo usermod -aG sudo "$user"
        sudo mkdir -p /home/$user/.ssh
        echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" | sudo tee /home/$user/.ssh/authorized_keys >/dev/null
        sudo chown -R "$user:$user" /home/$user/.ssh
        sudo chmod 700 /home/$user/.ssh
        sudo chmod 600 /home/$user/.ssh/authorized_keys
    fi
done
echo "-----------------------------------------------------------------------------------------------------------------------------------------"
echo " ALL CONFIGURATION DONE "
