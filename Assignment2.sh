#!/bin/bash

# Function to print section headers
print_header() {
    echo "#############################################"
    echo "## $1"
    echo "#############################################"
}

# Function to print informative messages
print_info() {
    echo "INFO: $1"
}

# Function to print errors
print_error() {
    echo "ERROR: $1" >&2
}

# Function to check if a package is installed
package_installed() {
    dpkg -l "$1" &>/dev/null
}

# Function to check if a user exists
user_exists() {
    id "$1" &>/dev/null
}

# Function to update netplan configuration for the specified interface
update_netplan_config() {
    local interface=$1
    local address=$2
    local gateway=$3
    local dns_server=$4
    local dns_search_domains=$5

    cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml >/dev/null
network:
  version: 2
  ethernets:
    $interface:
      addresses: [$address]
      gateway4: $gateway
      nameservers:
        addresses: [$dns_server]
        search: [$dns_search_domains]
EOF

    sudo netplan apply
}

# Function to update /etc/hosts file
update_hosts_file() {
    local ip_address=$1
    local hostname=$2

    sudo sed -i "/$hostname/d" /etc/hosts # Remove old entry if exists
    echo "$ip_address $hostname" | sudo tee -a /etc/hosts >/dev/null
}

# Function to install required packages
install_packages() {
    local packages=(apache2 squid)

    for pkg in "${packages[@]}"; do
        if ! package_installed "$pkg"; then
            print_info "Installing $pkg"
            sudo apt-get install -y "$pkg" || {
                print_error "Failed to install $pkg"
                return 1
            }
        else
            print_info "$pkg is already installed"
        fi
    done
}

# Function to configure ufw firewall
configure_firewall() {
    sudo ufw --force reset
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow from 192.168.16.0/24 to any port 3128
    sudo ufw enable
}

# Function to create user accounts
create_user_accounts() {
    local users=("dennis" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")

    for user in "${users[@]}"; do
        if ! user_exists "$user"; then
            print_info "Creating user $user"
            sudo adduser --disabled-password --gecos "" "$user" || {
                print_error "Failed to create user $user"
                return 1
            }
        else
            print_info "User $user already exists"
        fi

        # Configure SSH keys for the user
        sudo mkdir -p "/home/$user/.ssh"
        sudo cp "/root/.ssh/authorized_keys" "/home/$user/.ssh/"
        sudo chown -R "$user:$user" "/home/$user/.ssh"
        sudo chmod 700 "/home/$user/.ssh"
        sudo chmod 600 "/home/$user/.ssh/authorized_keys"

        # Add sudo access for dennis
        if [[ "$user" == "dennis" ]]; then
            sudo usermod -aG sudo "$user"
        fi
    done
}

# Main script starts here
print_header "Updating Network Configuration"
update_netplan_config "ens3" "192.168.16.21/24" "192.168.16.2" "192.168.16.2" "home.arpa localdomain" || {
    print_error "Failed to update network configuration"
    exit 1
}

print_header "Updating /etc/hosts file"
update_hosts_file "192.168.16.21" "server1" || {
    print_error "Failed to update /etc/hosts file"
    exit 1
}

print_header "Installing Required Packages"
install_packages || {
    print_error "Failed to install required packages"
    exit 1
}

print_header "Configuring Firewall"
configure_firewall || {
    print_error "Failed to configure firewall"
    exit 1
}

print_header "Creating User Accounts"
create_user_accounts || {
    print_error "Failed to create user accounts"
    exit 1
}

print_header "Script Execution Complete"
