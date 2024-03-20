#!/bin/bash

# Network Interface Configuration
echo "WE WILL NOW CONFIGURE NETWORK CONFIGURATION"
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
echo "WE WILL NOW UPDATE /etc/hosts file..."
echo "192.168.16.21 server1" | sudo tee -a /etc/hosts

# Software Installation
echo "wE WILL NOY INSTALL APACHE AND SQUID "
sudo apt update
sudo apt install -y apache2 squid

# Firewall Configuration
echo "WE WILL NOW SET UP THE UFW FIREWALL"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 3128

# User Account Management
echo "WE WILL NOW CREATE THE USER ACCOUNTS "
for user in dennis aubrey captain snibbles brownie scooter sandy perrier cindy tiger yoda; do
  sudo adduser --gecos "" --disabled-password $user
  if [ $user = "dennis" ]; then
    echo "$user ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$user
    sudo mkdir /home/$user/.ssh
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" | sudo tee /home/$user/.ssh/authorized_keys
  fi
done

echo " ALL CONFIGURATION DONE "
