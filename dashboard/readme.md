# Installing dashboard

---> [Original tutorial](https://rancher.com/docs/k3s/latest/en/installation/kube-dashboard/)

## Deploy dashboard
```shell
GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
rkubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
```

## Deploy user config

```shell
rkubectl create -f dashboard.admin-user.yaml -f dashboard.admin-user-role.yaml 

rkubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
```


## Run proxy

```shell
rkubectl proxy
```

[Proxy Dashboard URL](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

