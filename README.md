Project for provisioning 2 node MicroK8S cluster on a windows pc

##
windows 10 pro or later with multipass and jq installed.

If you have chocolatey installed run following command, else follow guide https://microk8s.io/docs/ives#heading--winnstall-alternatidows
´´´
choco install multipass
choco install jq
´´´

## Provision from git-bash

´´´
./install.sh
´´´

## Teardown from git-bash
´´´
./teardown.sh
´´´

## Update version 
You can update VMs version of microK8S on the fly
See more details https://microk8s.io/docs/setting-snap-channel

´´´
multipass list
snap info microk8s

#On each VM
multipass shell <VM>
sudo snap refresh microk8sedge --channel=1.24/stable
´´´

## Get kubeconfig
´´´
microk8s config
´´´
Find a way to add it to your local kubeconfig

