# Bootstrapping 


## Bootstrap rockpi device:

This will update gpg keys for ubuntu focal on the rock-pi device

```shell 
ansible-playbook -i rock-pi-init.yaml init.yaml
```

## Bootstrap usermanagment

### Generating password
Before applying role new password has to be generated and set in the _usermanagement/vars->password_.
E.g.: ```docker run --rm -it flyinprogrammer/mkpasswd -m sha-512```

Creates user for every device and disables default users.
**hosts-init.yaml** is used only once. After that **hosts.yaml** should be used.
```shell 
ansible-playbook -i hosts-init.yaml usermanagement.yaml
```    

## Install k3s

```shell
ansible-playbook -i hosts.yaml k3s.yaml
```




