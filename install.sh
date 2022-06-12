#!/bin/bash

VMs="microk8s-vm1 microk8s-vm2"
for vm in $VMs
do
  echo Launchng $vm ...
  multipass launch --name $vm --mem 4G --disk 20G
  EXECUTE="multipass exec $vm -- "
  echo Installing microk8s on $vm ...
  $EXECUTE sudo snap install microk8s --classic --channel=1.24/stable
  echo Forwarding tracfic from $vm to host ...
  $EXECUTE sudo iptables -P FORWARD ACCEPT
done
