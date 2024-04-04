#!/bin/bash

desired_name=""
desired_ip=""
desired_host=""
desired_host_ip=""


# NOW WE WILL UPDATE HOSTNAME-------------------------------------------------------------------------------------------
if [ "$desired_name" != "" ]; then
    hostnamectl set-hostname "$desired_name"
fi

# NOW WE WILL UPDATE HOSTT-------------------------------------------------------------------------------------------------
if [ "$desired_host" != "" ] && [ "$desired_host_ip" != "" ]; then
    echo "$desired_host_ip\t$desired_host" >> /etc/hosts
fi

# NOW WE WILL UPDATE IP ADDRESSS-------------------------------------------------------------------------------------------------------
if [ "$desired_ip" != "" ]; then
    sed -i "/^address/c\    address $desired_ip/32" /etc/netplan/01-netcfg.yaml
    sed -i "/^hosts/c\\$desired_ip\t$desired_name" /etc/hosts
    netplan apply
fi


# HERE IS ALL ARGUEMENTS-------------------------------------------------------------------------------------------------------------
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


#ALL CONFIGURATIONS DONE---------------------------------------------------------------------------------------------------------------------------------
