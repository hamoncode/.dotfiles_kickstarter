#!/bin/bash

# Scan for available Wi-Fi networks and list them with numbered indexes
echo "Scanning for available Wi-Fi networks..."
available_networks=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | awk 'NR>1 {for(i=1;i<=NF-2;i++) printf $i " "; print ""}' | nl -w 2 -s ': ')

echo "$available_networks"

# Ask the user to enter the number corresponding to the network they want to connect to
echo "Enter the number of the network you want to connect to: "
read network_number

# Extract the SSID based on the selected number
ssid=$(echo "$available_networks" | sed -n "${network_number}p" | cut -d ':' -f2- | xargs)

# Display the selected SSID for confirmation
echo "You selected: $ssid"

# Ask for the Wi-Fi password
echo "Enter the password for '$ssid': "
read -s password

# Attempt to connect to the selected Wi-Fi network
nmcli device wifi connect "$ssid" password "$password"

# Check if the connection was successful
if [ $? -eq 0 ]; then
    echo "Successfully connected to $ssid"
else
    echo "Failed to connect to $ssid"
fi

