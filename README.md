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
`pushd ansible && ansible-playbook -i hosts k3s.yaml && popd`


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

