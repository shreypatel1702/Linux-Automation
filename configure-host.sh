#!/bin/bash

# Default values
desired_name=""
desired_ip=""
desired_host=""
desired_host_ip=""

# Parse command line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -name)
            desired_name="$2"
            shift 2
            ;;
        -ip)
            desired_ip="$2"
            shift 2
            ;;
        -hostentry)
            desired_host="$2"
            desired_host_ip="$3"
            shift 3
            ;;
        -verbose)
            verbose=true
            shift 1
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Update hostname
if [ "$desired_name" != "" ]; then
    hostnamectl set-hostname "$desired_name"
fi

# Update IP address
if [ "$desired_ip" != "" ]; then
    sed -i "/^address/c\    address $desired_ip/32" /etc/netplan/01-netcfg.yaml
    sed -i "/^hosts/c\\$desired_ip\t$desired_name" /etc/hosts
    netplan apply
fi

# Update host entry
if [ "$desired_host" != "" ] && [ "$desired_host_ip" != "" ]; then
    echo "$desired_host_ip\t$desired_host" >> /etc/hosts
fi
