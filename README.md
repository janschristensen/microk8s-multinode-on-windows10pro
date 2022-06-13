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
multipass exec microk8s-vm2 -- sudo microk8s join 172.30.255.126:25000/df0d968c3083f90b5ffa67341e684ab8/78c3fbfd3e31

```

## Native kubectl
### Install
```
multipass exec microk8s-vm1 -- sudo snap install kubectl --classic
```

### Run
```
multipass exec microk8s-vm1 -- kubectl get no
```

## Kubectl via multipass
```
multipass exec microk8s-vm1 -- microk8s kubectl get no
```

## Howto kubectl from host to vm1
On each vm machines networkadapter enable NIC-team.


## Get kubeconfig from vm1
```
multipass shell microk8s-vm1
microk8s config
```
Or via multipass directly to file
```
multipass exec microk8s-vm1 -- sudo microk8s config > configs/kubeconfig
```

## Merge configs

On master vm this should work
export KUBECONFIG=~/.kube/config:$(pwd)/configs/kubeconfig

You can flatten these into a third file with kubectl config view --flatten

## Verify nodes via kubectl
```
kubectl get no
```

Yields:
```
NAME     $ kubectl       STATUS   ROLES    AGE    VERSION
microk8s-vm1   Ready    <none>   74m    v1.24.0-2+59bbb3530b6769
microk8s-vm2   Ready    <none>   2m6s   v1.24.0-2+59bbb3530b6769
```

## Remove vm networkadapter
If you accidently creat a VMNetworkAdapter via gui twice one of them is disabled and impossible to delete from GUI.

You can try with these powershell command.

Remember to turnoff vms.
```
Get-VMNetworkAdapter -ManagementOS
Remove-VMNetworkAdapter -ManagementOS -Name <name-goes-here>
```

Otherwise you can delete via device settings under control panel in windows.

## Links
* https://multipass.run/
* https://microk8s.io/
* https://docs.microsoft.com/en-us/powershell/module/hyper-v/?view=windowsserver2019-ps
