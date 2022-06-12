# MicroK8S cluster on windows
Experimenting with setting up a multinode MicroK8S with multipass and utilizing windows hyper-v. 



## Preregs
* windows 10 pro or later 
* with multipass
* jq installed.

Install with chocolatey or else follow guide https://microk8s.io/docs/ives#heading--winnstall-alternatidows

### Install with chocoatey
```
choco install multipass
choco install jq
```

## Provision from git-bash
```
./install.sh
```

## Teardown from git-bash
```
./teardown.sh
```

## Update version 
You can update VMs version of microK8S on the fly
See more details https://microk8s.io/docs/setting-snap-channel

```
multipass list
snap info microk8s

#On each VM
multipass shell <VM>
sudo snap refresh microk8sedge --channel=1.24/stable
```

## Get kubeconfig
```
microk8s config
```
Or via multipass
```
multipass exec microk8s-vm1 -- sudo microk8s config > configs/kubeconfig
```

## Merge configs
For this to work on host machine, some futher network needs to be configured it seems.

On master vm this should work
export KUBECONFIG=~/.kube/config:$(pwd)/configs/kubeconfig


## View configs
```
kubectl config view --flatten 
```

## Add node
Get the token from master vm
```
multipass exec microk8s-vm1 -- microk8s add-node
```

Use token from master on another vm
```
multipass exec microk8s-vm2 -- microk8s add-node
```

## kubectl
Install
```
multipass exec microk8s-vm1 -- sudo snap install kubectl --classic
```

Run
```
multipass exec microk8s-vm1 -- kubectl get no

# without kubectl installed
multipass exec microk8s-vm1 -- microk8s kubectl get no
```
## Next
* Howto kubectl from host to vm1


## Links
* https://multipass.run/
* https://microk8s.io/



