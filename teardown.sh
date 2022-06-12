#!/bin/bash
VM=$(multipass list --format json | jq '.[][].name' | grep microk8s | tail -n 1 | xargs echo ) 
while [ "$VM" != "" ]
do
 echo Stopping $VM ...
 multipass stop $VM
 echo Deleting $VM ... 
 multipass delete $VM
 echo Running purge $VM ..
 multipass purge
 sleep 1
 VM=$(multipass list --format json | jq '.[][].name' | grep microk8s | tail -n 1 | xargs echo ) 
done
echo done!
