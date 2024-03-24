# berry-k3s
# Installation

1. Flash SD with Rapsberry OS. 
  In my case 
- Raspberry Imager (https://www.balena.io/etcher/)
- Rapsberry OS Lite (https://www.raspberrypi.com/software/operating-systems/)


2. Allow ssh into the OS
##Rapsberry PI OS bullseye < 11 

After flashing run following:
`touch /Volumes/boot/ssh`

##Rapsberry PI OS bullseye >= 11 
In the bullseye version 11 the user `pi` doesn't exist and has to be created. (https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/)
Hence ssh has to be enabled during flashing.

3. Copy publickey to ssh without password.
e.g.: `ssh-copy-id -i ~/.ssh/id_rsa.pub pi@raspberrypi.local`

In my case:

`ssh-copy-id -i ~/.ssh/id_rsa.pub pi@berry-controller-1.local`

`ssh-copy-id -i ~/.ssh/id_rsa.pub pi@berry-worker-1.local`

`ssh-copy-id -i ~/.ssh/id_rsa.pub pi@berry-worker-2.local`

`ssh-copy-id -i ~/.ssh/id_rsa.pub pi@berry-worker-3.local`

4. Deploy k3s via ansible
`pushd ansible && ansible-playbook -i hosts.yaml k3s.yaml && popd`


## Rock PI bootstrap:
SSH with username: rock password rock
create user pi:
`sudo useradd -mG sudo pi`
`sudo chsh -s /bin/bash pi`
reset password
`sudo passwd pi`
`hostnamectl set-hostname berry-controller-1`

set nopassword for pi user
`sudo visudo /etc/sudoers` 
`pi ALL=(ALL) NOPASSWD: ALL`


Edit `/etc/hosts` and add `berry-controller-1`
`sudo reboot`

`ssh-copy-id -i ~/.ssh/id_rsa.pub pi@berry-controller-1.local`


Delete default rock user:
`sudo deluser rock`
`id rock` ### should return no users

If running on ubntu focal, radxa apt port might have outdated signatures, if so, when running `apt update` you will see something like:
```
W: GPG error: http://apt.radxa.com/focal-stable focal InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 9B98116C9AA302C7
E: The repository 'http://apt.radxa.com/focal-stable focal InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

If that is the case run:
```
export DISTRO=focal-stable
wget -O - apt.radxa.com/$DISTRO/public.key | sudo apt-key add -
```

Now we can update to ubuntu jammy (22.04):

```
sudo apt update 
sudo apt upgrade
sudo apt dist-upgrade

sudo apt autoremove
sudo apt install update-manager-core

sudo do-release-upgrade 
```

## Install auto update controller

rkubectl apply -f https://github.com/rancher/system-upgrade-controller/releases/latest/download/system-upgrade-controller.yaml


##TODO: 
add missing
NFS disk mount to NFS ansible
```ssh 
pi@berry-controller-1:~$ #sudo e2label /dev/sda1 "NFS"
pi@berry-controller-1:~$ mount -t ext4 | grep /dev/sda1
pi@berry-controller-1:~$ sudo e2label /dev/sda1 "NFS"
```
