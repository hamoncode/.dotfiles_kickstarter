#!/bin/bash

ip addr add 10.0.0.20/24 dev enp3s0 #|| { echo " ip addr failed" ; exit 1 ;
ip link set enp3s0 || { echo " second ifconfig failed" ; exit 1 ; 

echo "connection réussi"
