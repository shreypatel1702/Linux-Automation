#!/bin/bash

# Network Interface Configuration
echo "NOW WE WILL DO NETWORK CONFIGURATION---------------------------------------------------------------------------------------------------------------------------------"
sudo bash -c 'cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses: [192.168.16.21/24] # Change this IP address as needed
      gateway4: 192.168.16.2
      nameservers:
        addresses: [192.168.16.2]
        search: [home.arpa, localdomain]
EOF'
sudo netplan apply

# Hosts File Update
echo "NOW WE WILL UPDATE /ETC/HOSTS-----------------------------------------------------------------------------------------------------------------------"
echo "192.168.16.21 server1" | sudo tee -a /etc/hosts 

# Software Installation
echo "NOW WE WILL INSTALL APACHE2 and SQUID PACKAGES----------------------------------------------------------------------------------------------------------------------------"
sudo apt update
sudo apt install -y apache2 squid

# Firewall Configuration
echo "WE WILL BE SETTING UP THE FIREWALL---------------------------------------------------------------------------------------------------------------------------------------"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 3128

# User Account Management
echo "NOW WE WILL BE CREATING THE USER ACCOUNT MANAGEMENT------------------------------------------------------------------------------------------------------------------------------"
for user in dennis aubrey captain snibbles brownie scooter sandy perrier cindy tiger yoda; do
  sudo adduser --gecos "" --disabled-password $user
  if [ $user = "dennis" ]; then
    echo "$user ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$user
    sudo mkdir /home/$user/.ssh
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" | sudo tee /home/$user/.ssh/authorized_keys
  fi
done

echo "WE HAVE SUCCESSFULLY COMPLETED ALL THE CONFIGURATIONS----------------------------------------------------------------------------------------------------------------------------------------"
