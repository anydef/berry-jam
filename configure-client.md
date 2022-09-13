# Client Configuration
Configuring client to access remote server

Install k8s cli: 
```bash 
brew install kubernetes-cli
```

Copy client configuration from the server and replace k3s controller id with one visible in the network 

```bash
scp pi@berry-main.local:/etc/rancher/k3s/k3s.yaml $HOME/.kube/config-berry-k3s
K3S_MAIN_IP=$(ping -c1 berry-main.local | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
sed -i '' 's/127\.0\.0\.1/'"$K3S_MAIN_IP"'/g' $HOME/.kube/config-berry-k3s
```

Put alias function for convenient access. (or merge .kube/config with .kube/config-berry-k3s with different contexts)
```shell 
rkubectl() { kubectl --kubeconfig ~/.kube/config-berry-k3s $@ }
```

Test it can connect to the server:
```shell
rkubectl get pods 
```
