# berry-k3s
# Installation

1. Flash SD with Rapsberry OS. 
  In my case 
- balenaetcher (https://www.balena.io/etcher/)
- Rapsberry OS Lite (https://www.raspberrypi.com/software/operating-systems/)


2. Allow ssh into the OS
##Rapsberry PI OS bullseye < 11 

After flashing run following:
`touch /Volumes/boot/ssh`

##Rapsberry PI OS bullseye >= 11 
In the bullseye version 11 the user `pi` doesn't exist and has to be created. (https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/)

`echo "pi:raspberry" > /Volumes/boot/userconf`


